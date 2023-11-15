//
//  BooksCollectionViewCell.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//

import UIKit

final class BooksCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    static var identifier: String {
        String(describing: BooksCollectionViewCell.self)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with cell: BooksCellViewModel) {
        imageView.image = cell.image
    }
}
// MARK: - UI
private extension BooksCollectionViewCell{
    func setView() {
        contentView.addSubview(imageView)
    }
    func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }
}
