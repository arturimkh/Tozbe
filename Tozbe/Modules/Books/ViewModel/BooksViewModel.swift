//
//  BooksViewModel.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//

import Foundation
class BooksViewModel {
    private let userManager: UserManager
    init(userManager: UserManager){
        self.userManager = userManager
    }
    public func didUserLoggedIn() -> Bool {
        let state = userManager.isUserLoggedIn()
        return state
    }
}
