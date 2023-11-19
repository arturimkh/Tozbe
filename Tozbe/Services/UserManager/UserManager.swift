//
//  UserManager.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//

import Foundation

struct UserManager {
    private let isLoggedInKey = "isLoggedIn"
    
    func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: isLoggedInKey)
    }
    
    func setLoggedInStatus(_ isLoggedIn: Bool) {
        UserDefaults.standard.set(isLoggedIn, forKey: isLoggedInKey)
    }
    func saveData(model: UserModel) {
        if let encodedData = try? JSONEncoder().encode(model) {
            UserDefaults.standard.set(encodedData, forKey: "userModel")
        }
        setLoggedInStatus(true)
    }
    func getData() -> UserModel{
        guard let savedData = UserDefaults.standard.data(forKey: "userModel") else {return UserModel(phoneNumber: "", phoneContact1: "", phoneContact2: "", phoneContact3: "", audioLenght: "", locationDelayLenght: "")}
        guard let data = try? JSONDecoder().decode(UserModel.self, from: savedData) else {fatalError("unable to decode")}
        return data
    }
}
