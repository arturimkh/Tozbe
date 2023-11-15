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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false // Отключаем скроллинг
        return collectionView
    }()
    
    private let booksViewModel: BooksViewModel
    
// MARK: - Init
    init(booksViewModel: BooksViewModel) {
        self.booksViewModel = booksViewModel
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
    }
}
// MARK: - UI
private extension BooksViewController {
    func setView() {
        view.addSubview(booksCollectionView)
    }
    func setConstraints() {
        NSLayoutConstraint.activate([
            booksCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            booksCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            booksCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            booksCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -100)
        ])
    }
}
// MARK: - DataSource
extension BooksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}
// MARK: - Delegate
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
