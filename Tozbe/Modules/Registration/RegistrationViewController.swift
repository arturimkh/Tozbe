//
//  RegistrationVC.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    private let viewModel: RegistrationViewModel
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        view.backgroundColor = .red
    }
}
