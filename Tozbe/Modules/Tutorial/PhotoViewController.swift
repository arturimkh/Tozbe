//
//  PhotoViewController.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 21.11.2023.
//
import UIKit

class PhotoViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { [weak self] _, _ in
            return self?.createImageGalerySection()
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    let photos = ["xmark", "house", "play", "ball"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setView()
        setConstraints()
    }
}
// MARK: - UI
private extension PhotoViewController {
    func setView() {
        view.addSubview(collectionView)
    }
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),

        ])
    }
    func createImageGalerySection() -> NSCollectionLayoutSection{

        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(collectionView.bounds.size.height-200)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
// MARK: - UICollectionViewDataSource
extension PhotoViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.image = UIImage(systemName: photos[indexPath.item])
        imageView.contentMode = .scaleAspectFit
        cell.contentView.addSubview(imageView)
        cell.backgroundColor = .red
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
