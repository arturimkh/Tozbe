//
//  TabBarViewController.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 18.11.2023.
//

import UIKit

final class TabBarViewController: UITabBarController,UITabBarControllerDelegate {
    private let userManager = UserManager()
    var shadowView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarUI()
        configureTabBarItems()
        addCustomTabBarView()
    }
    private func configureTabBarItems() {
        var images = [ UIImage(systemName: "gearshape"), UIImage(systemName: "person"), UIImage(systemName: "info.circle")]
        var arrayOfControllers: [UIViewController] = [
             ControllerFactory.create(.registration),
             ControllerFactory.create(.main),
             ControllerFactory.create(.info)
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
    private func addCustomTabBarView() {
        shadowView.frame = tabBar.frame
        
        addShadowLayer(at: 0, radius: 2, height: -2)
        addShadowLayer(at: 1, radius: 8, height: -2)
        addShadowLayer(at: 2, radius: 38, height: -7)
        
        view.addSubview(shadowView)
        view.bringSubviewToFront(tabBar)
    }
    
    private func addShadowLayer(at layer: UInt32, radius: CGFloat, opacity: Float = 0.34, height: Int) {
        let shadowLayer = CALayer()
        shadowLayer.frame = tabBar.bounds
        shadowLayer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 10).cgPath
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowRadius = radius
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowOffset = CGSize(width: 0, height: height)
        shadowLayer.cornerRadius = tabBar.layer.cornerRadius + 1
        shadowLayer.backgroundColor = UIColor.clear.cgColor
        
        shadowView.layer.insertSublayer(shadowLayer, at: layer)
    }
}
