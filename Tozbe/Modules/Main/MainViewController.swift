//
//  MainViewController.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 16.11.2023.
//

import UIKit
import MessageUI
class MainViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
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
    private lazy var sosTextField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите текст сообщения"
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    private let attentionAlert: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = """
                    Внимание!
                    Началась отправка SOS сообщения.
                    Вы можете остановить SOS сигнал нажав на кнопку СТОП.
                    """
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("СТОП", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapStop), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
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
    func displayMessageInterface() {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        let userModel = viewModel.getUserModel()
        composeVC.recipients = [userModel.phoneContact1,userModel.phoneContact2,userModel.phoneContact3]
        composeVC.body = sosTextField.text!
        
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            print("Can't send messages.")
        }
    }
    @objc
    private func didTapSos() {
        stopButton.isHidden = false
        attentionAlert.isHidden = false
        displayMessageInterface()
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    @objc
    private func didTapStop() {
        stopButton.isHidden = true
        attentionAlert.isHidden = true
    }
}
// MARK: - TextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
// MARK: - UI
private extension MainViewController {
    func setView() {
        view.addSubview(grayLabel)
        view.addSubview(sosButton)
        view.addSubview(sosTextField)
        view.addSubview(attentionAlert)
        view.addSubview(stopButton)
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
        NSLayoutConstraint.activate([
            attentionAlert.topAnchor.constraint(equalTo: sosTextField.bottomAnchor,constant: 30),
            attentionAlert.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30),
            attentionAlert.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
        NSLayoutConstraint.activate([
            stopButton.topAnchor.constraint(equalTo: attentionAlert.bottomAnchor,constant: 30),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
