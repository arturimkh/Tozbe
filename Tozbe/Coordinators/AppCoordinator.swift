//
//  AppCoordinator.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//

import Foundation
import UIKit
final class AppCoordinator{
    static let shared = AppCoordinator()
    
    private var _window: UIWindow? {
        UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last
    }
    var window: UIWindow?
    
    func start(on window: UIWindow?) {
        self.window = window
        showBooks()
    }
    
    func showBooks() {
        let booksVC = ControllerFactory.create(.books)
        let navCon = UINavigationController(rootViewController: booksVC)
        window?.rootViewController = navCon
    }
}
