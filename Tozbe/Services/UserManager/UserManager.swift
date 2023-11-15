//
//  UserManager.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//

import Foundation

struct UserManager {
    private static let isLoggedInKey = "isLoggedIn"
    
    static func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: isLoggedInKey)
    }
    
    static func setLoggedInStatus(_ isLoggedIn: Bool) {
        UserDefaults.standard.set(isLoggedIn, forKey: isLoggedInKey)
    }
}
