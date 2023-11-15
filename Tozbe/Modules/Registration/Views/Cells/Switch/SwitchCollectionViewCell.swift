//
//  SwitchCollectionViewCell.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//

import UIKit

final class SwitchCollectionViewCell: UICollectionViewCell {
    static var identifier: String {
        String(describing: SwitchCollectionViewCell.self)
    }
    let labelInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "Отправка обновленной локации"
        return label
    }()
    let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
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
extension SwitchCollectionViewCell {
    func setConstraints() {
        contentView.addSubview(labelInfo)
        contentView.addSubview(switcher)
        NSLayoutConstraint.activate([
            switcher.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            switcher.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10),
        ])
        NSLayoutConstraint.activate([
            labelInfo.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelInfo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            labelInfo.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10),
            labelInfo.rightAnchor.constraint(equalTo: switcher.leftAnchor)
        ])
    }
}
