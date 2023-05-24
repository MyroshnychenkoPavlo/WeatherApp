//
//  MainOpenWeather.swift
//  WeatherApp
//
//  Created by Pavlo Myroshnychenko on 20.05.2023.
//

import Foundation

// MARK: - Forecast
struct Forecast: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather
        case dtTxt = "dt_txt"
    }
}


// MARK: - MainClass
struct MainClass: Codable {
    let temp, tempMin, tempMax: Double
    let  humidity: Int


    enum CodingKeys: String, CodingKey {
        case temp 
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let description: String
    let icon: String
}

