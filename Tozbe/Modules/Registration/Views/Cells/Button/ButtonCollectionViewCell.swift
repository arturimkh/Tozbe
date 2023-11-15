//
//  ButtonCollectionViewCell.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//

import UIKit

final class ButtonCollectionViewCell: UICollectionViewCell {
    static var identifier: String {
        String(describing: ButtonCollectionViewCell.self)
    }
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray
        button.setTitle("Сохранить", for: .normal)
        button.isEnabled = false
        button.layer.cornerRadius = 10
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
private extension ButtonCollectionViewCell {
    func setConstraints() {
        contentView.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor,constant: 10),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
