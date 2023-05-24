//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Pavlo Myroshnychenko on 21.05.2023.
//

import Foundation
import CoreLocation

// MARK: - LocationManager
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    // MARK: - Published
    @Published var location: CLLocationCoordinate2D?
    
    // MARK: - Life cycle
    override init() {
        super.init()
        manager.delegate = self
    }
    
    // MARK: - Public methods
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
