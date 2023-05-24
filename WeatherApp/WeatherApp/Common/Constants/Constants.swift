//
//  Constants.swift
//  WeatherApp
//
//  Created by Pavlo Myroshnychenko on 20.05.2023.
//

import Foundation

// MARK: - Constants {
struct Constants {
    
    // MARK: - NetworkManager
    struct NetworkManager {
        static let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
        static let latitude = "lat"
        static let longitude = "lon"
        static let appId = "appid"
        static let appIdValue = "ffb9827c10879a7b07ec1f8d02b3d05f"
        static let units = "units"
        static let metric = "metric"
        static let q = "q"
    }
}
