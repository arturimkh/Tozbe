//
//  TextFieldsCollectionViewCell.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//

import UIKit

protocol TextFieldsCollectionViewCellDelegate: AnyObject {
    func showAlert()
}

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
        textField.delegate = self
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private let nessecaryTextlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    weak var delegate: TextFieldsCollectionViewCellDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with cellViewModel: TextFieldsCollectionViewCellViewModel,delegate: TextFieldsCollectionViewCellDelegate) {
        self.delegate = delegate
        let text = cellViewModel.text
        if cellViewModel.nessecary {
            nessecaryTextlabel.text = "*Обязательно"
        } else {
            nessecaryTextlabel.text = ""
        }
        textField.placeholder = text
        imageView.image = UIImage(systemName: cellViewModel.image.rawValue)
        textField.text = cellViewModel.textFieldText
        validateField(cellViewModel.nessecary)
    }
    public func getData() -> String {
        guard let text = textField.text else {return ""}
        return text
    }
    private func validateField(_ isNessecary: Bool) {
        if isNessecary {
            if textField.text == "" {
                delegate?.showAlert()
            }
        }
    }
}

// MARK: - TextFieldDelegate
extension TextFieldsCollectionViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
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
        contentView.addSubview(nessecaryTextlabel)
        NSLayoutConstraint.activate([
            nessecaryTextlabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nessecaryTextlabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 15),
            nessecaryTextlabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 85),
            nessecaryTextlabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 15),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 25)
        ])
        contentView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            textField.leftAnchor.constraint(equalTo: imageView.rightAnchor,constant: 15),
            textField.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
