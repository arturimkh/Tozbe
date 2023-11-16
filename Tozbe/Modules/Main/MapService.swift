//
//  MapService.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 16.11.2023.
//

import Foundation
import CoreLocation
final class MapService: NSObject{
    
    private let manager = CLLocationManager()
    
    private var completion: ((CLLocation) -> Void)?
    
    public func getUserLocation(completion: @escaping((CLLocation) -> Void)){
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.startUpdatingLocation()
    }
}

extension MapService: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        completion?(location)
        manager.stopUpdatingLocation()
    }
}
