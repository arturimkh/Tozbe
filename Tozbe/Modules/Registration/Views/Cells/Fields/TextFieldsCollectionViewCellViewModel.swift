//
//  TextFieldsCollectionViewCellViewModel.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//

import Foundation
enum ImageTextFieldTypes: String {
    case phone = "phone.fill"
    case location = "location.circle.fill"
}
struct TextFieldsCollectionViewCellViewModel {
    let text: String
    let image: ImageTextFieldTypes
    let nessecary: Bool
    let textFieldText: String
    init(text: String, image: ImageTextFieldTypes, nessecary: Bool = false, textFieldText: String) {
        self.text = text
        self.image = image
        self.nessecary = nessecary
        self.textFieldText = textFieldText
    }
}
