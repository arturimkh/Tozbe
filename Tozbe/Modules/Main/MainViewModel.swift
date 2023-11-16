//
//  MainViewModel.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 16.11.2023.
//

import Foundation
import CoreLocation
final class MainViewModel{
    private let userManager: UserManager
    private let mapService = MapService()

    init(userManager: UserManager) {
        self.userManager = userManager
    }
    public func getUserModel() -> UserModel {
        return userManager.getData()
    }
    private func getLocation(_  completion: @escaping((CLLocationCoordinate2D) -> Void)) {
        mapService.getUserLocation{ myLocation in
            DispatchQueue.main.async {
                let location = CLLocationCoordinate2D(latitude: myLocation.coordinate.latitude, longitude: myLocation.coordinate.longitude)
                completion(location)
            }
        }
    }
    public func getGoogleUrl(_ completion: @escaping((String) -> Void)) {
        getLocation{ location in
            completion("https://www.google.com/maps/search/?api=1&query=\(location.latitude),\(location.longitude)")
        }
    }
}
