//
//  MainViewController.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 16.11.2023.
//

import UIKit

class MainViewController: UIViewController {
    private let grayLabel: UILabel = {
        let label = UILabel()
        label.text = "Отправь экстренное сообщение доверенным контактам"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font  = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .systemGray
        return label
    }()
    private lazy var sosButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 100
        button.backgroundColor = .systemGray
        let myAttribute = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 70)]
        let attributedString = NSAttributedString(string: "SOS", attributes: myAttribute)
        button.setAttributedTitle(attributedString, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(didTapSos), for: .touchUpInside)
        return button
    }()
    private lazy var sosTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "    Введите текст сообщения"
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        return textField
    }()
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
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
    }
    @objc
    private func didTapSos() {
        print("sos")
    }
}
// MARK: - UI
private extension MainViewController {
    func setView() {
        view.addSubview(grayLabel)
        view.addSubview(sosButton)
        view.addSubview(sosTextField)
    }
    func setConstraints() {
        NSLayoutConstraint.activate([
            grayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 25),
            grayLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            grayLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        NSLayoutConstraint.activate([
            sosButton.topAnchor.constraint(equalTo: grayLabel.bottomAnchor,constant: 30),
            sosButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sosButton.heightAnchor.constraint(equalToConstant: 200),
            sosButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        NSLayoutConstraint.activate([
            sosTextField.topAnchor.constraint(equalTo: sosButton.bottomAnchor,constant: 30),
            sosTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sosTextField.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30),
            sosTextField.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30),
            sosTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
