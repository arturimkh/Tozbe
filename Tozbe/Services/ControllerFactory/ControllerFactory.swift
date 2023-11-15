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
}

final class ControllerFactory{
    static func create(_ controller: ControllerFactoryType) -> UIViewController {
        switch controller {
        case .books:
            let viewModel = BooksViewModel()
            let viewController = BooksViewController(booksViewModel: viewModel)
            return viewController
        }
    }
}
