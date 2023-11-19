//
//  InfoViewController.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 18.11.2023.
//

import UIKit

final class InfoViewController: UIViewController {
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 1
        stackView.axis = .vertical
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setView()
        setConstraints()
        Constants.arrayOfInfoButtons.forEach { nameButton in
            let button = createButton(nameButton)
            buttonStackView.addArrangedSubview(button)
        }
    }
    
}
private extension InfoViewController {
    func createButton(_ text: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        button.backgroundColor = .systemGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }
    func setView() {
        view.addSubview(buttonStackView)
    }
    func setConstraints() {
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonStackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            buttonStackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
