//
//  MainViewController.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 16.11.2023.
//

import UIKit

class MainViewController: UIViewController {
    let viewModel: MainViewModel
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

}
