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
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = photos.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
        return pageControl
    }()
    private lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Понятно", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.isHidden = true
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.isUserInteractionEnabled
        return button
    }()
    let photos = ["firstTutorial", "secondTutorial", "thirdTutorial", "fourthTutorial"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setView()
        setConstraints()
    }
    func showAcceptButton() {
        acceptButton.isHidden = false
    }
    @objc
    private func didTapButton() {
        dismiss(animated: true)
    }
}
// MARK: - UI
private extension PhotoViewController {
    func setView() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        collectionView.addSubview(acceptButton)
    }
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor,constant: -200),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            acceptButton.topAnchor.constraint(equalTo: view.topAnchor,constant: 70),
            acceptButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20)
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
        imageView.image = UIImage(named: photos[indexPath.item])
        imageView.contentMode = .scaleAspectFit
        cell.contentView.addSubview(imageView)
        cell.backgroundColor = .systemGray
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
        if indexPath.row == photos.count - 1{
            showAcceptButton()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
