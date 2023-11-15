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
}

final class ControllerFactory{
    static func create(_ controller: ControllerFactoryType) -> UIViewController {
        switch controller {
        case .books:
            let userManager = UserManager()
            let viewModel = BooksViewModel(userManager: userManager)
            let viewController = BooksViewController(viewModel: viewModel)
            return viewController
        case.registration:
            let viewModel = RegistrationViewModel()
            let viewController = RegistrationViewController(viewModel: viewModel)
            return viewController
        }
    }
}
