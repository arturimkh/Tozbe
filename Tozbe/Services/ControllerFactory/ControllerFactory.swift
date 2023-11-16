//
//  ControllerFactory.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//

import Foundation
import UIKit
enum ControllerFactoryType {
    case books
    case registration
    case main
    case book(String)
}

final class ControllerFactory{
    static func create(_ controller: ControllerFactoryType) -> UIViewController {
        switch controller {
        case .books:
            let userManager = UserManager()
            let viewModel = BooksViewModel(userManager: userManager)
            let viewController = BooksViewController(viewModel: viewModel)
            return viewController
        case .registration:
            let userManager = UserManager()
            let viewModel = RegistrationViewModel(userManager: userManager)
            let viewController = RegistrationViewController(viewModel: viewModel)
            return viewController
        case .main:
            let userManager = UserManager()
            let viewModel = MainViewModel(userManager: userManager)
            let viewController = MainViewController(viewModel: viewModel)
            return viewController
        case .book(let name):
            let viewController = BookViewController(name: name)
            return viewController
        }
    }
}
