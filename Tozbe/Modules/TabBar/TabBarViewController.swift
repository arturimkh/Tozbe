//
//  TabBarViewController.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 18.11.2023.
//

import UIKit

final class TabBarViewController: UITabBarController,UITabBarControllerDelegate {
    private let userManager = UserManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarUI()
        configureTabBarItems()
    }
    private func configureTabBarItems() {
        var images = [ UIImage(systemName: "gearshape"), UIImage(systemName: "sos.circle"), UIImage(systemName: "info.circle")]
        var arrayOfControllers: [UINavigationController] = [
            UINavigationController(rootViewController: ControllerFactory.create(.registration)),
            UINavigationController(rootViewController: ControllerFactory.create(.main)),
            UINavigationController(rootViewController: ControllerFactory.create(.info))
        ]
        if userManager.isUserLoggedIn() {
            arrayOfControllers.swapAt(0, 1)
            images.swapAt(0, 1)
        }
        
        viewControllers = arrayOfControllers

        guard let viewControllers else { return }
        for (index, controller) in viewControllers.enumerated() {
            controller.tabBarItem.image = images[index]
        }
    }
    private func setupTabBarUI() {
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 24
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .gray
        
        let appearance = tabBar.standardAppearance
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        tabBar.standardAppearance = appearance
    }
}
