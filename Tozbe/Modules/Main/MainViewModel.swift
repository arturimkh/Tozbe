//
//  MainViewModel.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 16.11.2023.
//

import Foundation
final class MainViewModel{
    private let userManager: UserManager
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    public func getUserModel() -> UserModel {
        return userManager.getData()
    }
}
