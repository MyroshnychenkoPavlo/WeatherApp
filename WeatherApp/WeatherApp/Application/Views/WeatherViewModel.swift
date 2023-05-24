//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Pavlo Myroshnychenko on 21.05.2023.
//

import Foundation
import SwiftUI
import CoreLocation

// MARK: - DownloadViewModel
class WeatherViewModel: ObservableObject {
    
    // MARK: - Published
    @Published var locationManager = LocationManager()
    @Published var locationService: LocationService = LocationService()
    @Published private var network: NetworkManager = NetworkManager()
    @Published var response: Forecast?
    @Published var daysWeather: [DayWeather] = []
    
    // MARK: - Life cycle
    init() {
        locationManager.requestLocation()
    }
    
    // MARK: - Public methods
    func locationTapped(location: String) {
        locationService.getCoordinates(for: location) { location in
            self.network.fetchData(latitude: String(location.coordinate.latitude),
                                   longitude: String(location.coordinate.longitude)) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.response = response
                        self.daysWeather = []
                        let sortedKeys = self.dayDictionary(response: response).keys.sorted { lhs, rhs in
                            let lhsDate = MyDateFormater().convertToDate(day: lhs)
                            let rhsDate = MyDateFormater().convertToDate(day: rhs)
                            return lhsDate < rhsDate
                        }
                        sortedKeys.forEach {
                            self.daysWeather.append(self.weather(for: $0))
                        }
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
    }
    
    func dayDictionary(response: Forecast) -> [String : [List]] {
        var sortedList: [String : [List]] = [:]
        response.list.forEach { list in
            let key = MyDateFormater().convertToDay(date: list.dt)
            if var dayWeather = sortedList[key] {
                dayWeather.append(list)
                sortedList[key] = dayWeather
            } else {
                sortedList[key] = [list]
            }
        }
        return sortedList
    }
    
    func weather(for day: String) -> DayWeather {
        guard let response,
              let daysResponse = dayDictionary(response: response)[day] else { return DayWeather(title: "", averageTemperature: "", weatherIcon: "") }
        let averageTemperature = daysResponse.reduce(0.0, { sum, nextValue in
            return sum + nextValue.main.temp
        }) / Double(daysResponse.count)
        let title = day
        let icon = daysResponse.first?.weather.first?.icon ?? ""
        let weather = DayWeather(title: title, averageTemperature: String(format: "%.1f", averageTemperature), weatherIcon: icon)
        return weather
    }
    
    func onAppear(location: CLLocationCoordinate2D?) {
        if let location {
            self.network.fetchData(latitude: String(location.latitude),
                                   longitude: String(location.longitude)) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.response = response
                        self.daysWeather = []
                        let sortedKeys = self.dayDictionary(response: response).keys.sorted { lhs, rhs in
                            let lhsDate = MyDateFormater().convertToDate(day: lhs)
                            let rhsDate = MyDateFormater().convertToDate(day: rhs)
                            return lhsDate < rhsDate
                        }
                        sortedKeys.forEach {
                            self.daysWeather.append(self.weather(for: $0))
                        }
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
    }
    
    func detailedWeather(for day: String) -> [List] {
        guard let response else { return [] }
        return dayDictionary(response: response)[day] ?? []
    }
    
    func weatherIconURL(for string: String) -> URL? {
        let urlString = "https://openweathermap.org/img/w/\(string).png"
        return URL(string: urlString)
    }
}

struct DayWeather: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let averageTemperature: String
    let weatherIcon: String
}
