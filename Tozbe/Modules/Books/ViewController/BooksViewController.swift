//
//  ViewController.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//

import UIKit

final class BooksViewController: UIViewController {
    
    private lazy var booksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets.zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BooksCollectionViewCell.self, forCellWithReuseIdentifier: BooksCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    private lazy var invisibleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        return button
    }()
    private var imageDataSource: [BooksCellViewModel] = []
    private let viewModel: BooksViewModel
    
// MARK: - Init
    
    init(viewModel: BooksViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setView()
        setConstraints()
        appendImageDataSource()
        if viewModel.didUserLoggedIn() {
            let tutorialVC = ControllerFactory.create(.tutorial)
            present(tutorialVC, animated: true)
        }
    }
    private func appendImageDataSource() {
        Constants.arrayOfNameBooks.forEach { nameImage in
            let image = UIImage(named: nameImage)
            let cellViewModel = BooksCellViewModel(image: image)
            imageDataSource.append(cellViewModel)
        }
    }
    @objc
    private func didTap() {
        let tabBar = ControllerFactory.create(.tabBar)
        self.navigationController?.pushViewController(tabBar, animated: true)
    }
}

// MARK: - UI
private extension BooksViewController {
    func setView() {
        view.addSubview(booksCollectionView)
        view.addSubview(invisibleButton)
    }
    func setConstraints() {
        NSLayoutConstraint.activate([
            booksCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            booksCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            booksCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            booksCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -225)
        ])
        
        NSLayoutConstraint.activate([
            invisibleButton.topAnchor.constraint(equalTo: booksCollectionView.bottomAnchor),
            invisibleButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            invisibleButton.widthAnchor.constraint(equalToConstant: 150),
            invisibleButton.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
}
// MARK: - DataSource
extension BooksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BooksCollectionViewCell.identifier, for: indexPath) as! BooksCollectionViewCell
        cell.configure(with: imageDataSource[indexPath.row])
        return cell
    }
}
// MARK: - Delegate
extension BooksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pdfBookVc = ControllerFactory.create(.book(Constants.arrayOfNameBooks[indexPath.row]))
        self.navigationController?.pushViewController(pdfBookVc, animated: true)
    }
}

// MARK: - DelegateFlowLayout
extension BooksViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 3
        let spacing: CGFloat = 10
        let totalSpacing = (numberOfItemsPerRow - 1) * spacing
        let cellWidth = (collectionViewWidth - totalSpacing) / numberOfItemsPerRow

        let cellHeight: CGFloat = 175

        return CGSize(width: cellWidth, height: cellHeight)
    }
}
