//
//  RegistrationViewModel.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//

import Foundation
protocol RegistrationViewModelDelegate: AnyObject {
    func didLoadData()
}
class RegistrationViewModel {
    private let userManager: UserManager
    weak var delegate: RegistrationViewModelDelegate?
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    func getModel() -> UserModel {
        return userManager.getData()
    }
    func saveModel(_ array: [String]) {
        let userModel = UserModel(phoneNumber: array[0],
                                  phoneContact1: array[1],
                                  phoneContact2: array[2],
                                  phoneContact3: array[3],
                                  audioLenght: array[4],
                                  locationDelayLenght: array[5])
        userManager.saveData(model: userModel)
        delegate?.didLoadData()
    }
}
