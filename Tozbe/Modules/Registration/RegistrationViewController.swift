//
//  RegistrationVC.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//

import UIKit
private enum Sections: Int {
    case information
    case isLocationUpdate
    case saveButton
}
private enum Information: Int {
    case phone
    case contact1
    case contact2
    case contact3
    case timeOfDictaphone
    case locationUpdate
}
class RegistrationViewController: UIViewController {
    private let viewModel: RegistrationViewModel
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 35
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TextFieldsCollectionViewCell.self, forCellWithReuseIdentifier: TextFieldsCollectionViewCell.identifier)
        collectionView.register(SwitchCollectionViewCell.self, forCellWithReuseIdentifier: SwitchCollectionViewCell.identifier)
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    var dataSourceString: [String] = []
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setCollectionView()
        viewModel.delegate = self
    }
}
// MARK: - UI
private extension RegistrationViewController {
    func setCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
}

// MARK: - DataSource
extension RegistrationViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case Sections.information.rawValue:
            return 6
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let userModel = viewModel.getModel()
        
        switch indexPath.section {
            
        case Sections.information.rawValue:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextFieldsCollectionViewCell.identifier, for: indexPath) as! TextFieldsCollectionViewCell
            
            var cellViewModel: TextFieldsCollectionViewCellViewModel
            
            switch indexPath.row{
                
            case Information.phone.rawValue:
                cellViewModel = TextFieldsCollectionViewCellViewModel(text: "Номер телефона", image: .phone,nessecary: true,textFieldText: userModel.phoneNumber)
                cell.configure(with: cellViewModel, delegate: self)

            case Information.contact1.rawValue:
                cellViewModel = TextFieldsCollectionViewCellViewModel(text: "Доверенный контакт 1", image: .phone,nessecary: true,textFieldText: userModel.phoneContact1)
                cell.configure(with: cellViewModel, delegate: self)

            case Information.contact2.rawValue:
                cellViewModel = TextFieldsCollectionViewCellViewModel(text: "Доверенный контакт 2", image: .phone,textFieldText: userModel.phoneContact2)
                cell.configure(with: cellViewModel, delegate: self)

            case Information.contact3.rawValue:
                cellViewModel = TextFieldsCollectionViewCellViewModel(text: "Доверенный контакт 3", image: .phone,textFieldText: userModel.phoneContact3)
                cell.configure(with: cellViewModel, delegate: self)

            case Information.timeOfDictaphone.rawValue:
                cellViewModel = TextFieldsCollectionViewCellViewModel(text: "Продолжительность аудиозаписи", image: .location,nessecary: true,textFieldText: userModel.audioLenght)
                cell.configure(with: cellViewModel, delegate: self)

            case Information.locationUpdate.rawValue:
                cellViewModel = TextFieldsCollectionViewCellViewModel(text: "Отправлять новую локацию", image: .location,nessecary: true,textFieldText: userModel.locationDelayLenght)
                cell.configure(with: cellViewModel, delegate: self)

            default:
                cellViewModel = TextFieldsCollectionViewCellViewModel(text: "", image: .phone,textFieldText: "")
            }
            return cell
            
        case Sections.isLocationUpdate.rawValue:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SwitchCollectionViewCell.identifier, for: indexPath) as! SwitchCollectionViewCell
            return cell
            
        case Sections.saveButton.rawValue:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifier, for: indexPath) as! ButtonCollectionViewCell
            cell.configure(delegate: self)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}
extension RegistrationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.insetBy(dx: 20, dy: 0).width, height: 60)
    }
}
extension RegistrationViewController: ButtonCollectionViewCellDelegate {
    func didTapSave() {
        dataSourceString = []
        for section in 0..<collectionView.numberOfSections {
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                if let cell = collectionView.cellForItem(at: indexPath) {
                    if let textFieldsCell = cell as? TextFieldsCollectionViewCell {
                        let data = textFieldsCell.getData()
                        dataSourceString.append(data)
                    } else if let switchCell = cell as? SwitchCollectionViewCell {
                        let data = switchCell.getDataIsOn()
                        dataSourceString.append(data)
                    }
                }
            }
        }
        viewModel.saveModel(dataSourceString)
    }
}
extension RegistrationViewController: TextFieldsCollectionViewCellDelegate {
    func showAlert() {
        let title = "Внимание"
        let message = "Введите все обязательные поля"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
extension RegistrationViewController: RegistrationViewModelDelegate {
    func didLoadData() {
        collectionView.reloadData()
    }
}
