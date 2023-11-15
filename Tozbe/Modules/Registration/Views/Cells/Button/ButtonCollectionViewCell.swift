//
//  ButtonCollectionViewCell.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//

import UIKit
protocol ButtonCollectionViewCellDelegate: AnyObject {
    func didTapSave()
}

final class ButtonCollectionViewCell: UICollectionViewCell {
    static var identifier: String {
        String(describing: ButtonCollectionViewCell.self)
    }
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray
        button.setTitle("Сохранить", for: .normal)
        button.isEnabled = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        return button
    }()
    weak var delegate: ButtonCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(delegate: ButtonCollectionViewCellDelegate) {
        self.delegate = delegate
    }
    @objc
    private func didTap() {
        delegate?.didTapSave()
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
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
