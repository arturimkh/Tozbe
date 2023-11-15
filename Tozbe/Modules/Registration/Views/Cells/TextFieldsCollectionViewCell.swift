//
//  TextFieldsCollectionViewCell.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//

import UIKit

class TextFieldsCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        String(describing: TextFieldsCollectionViewCell.self)
    }
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with cellViewModel: TextFieldsCollectionViewCellViewModel) {
        textField.placeholder = cellViewModel.text
        imageView.image = UIImage(systemName: cellViewModel.image.rawValue)
    }
}
// MARK: - TextFieldDelegate
extension TextFieldsCollectionViewCell: UITextFieldDelegate {
    
}
// MARK: -UI
private extension TextFieldsCollectionViewCell {
    func setUpCell() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray.cgColor
        layer.cornerRadius = 10
    }

    func setConstraints() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor,constant: 15),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 25)
        ])
        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leftAnchor.constraint(equalTo: imageView.rightAnchor,constant: 15),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
