//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Pavlo Myroshnychenko on 20.05.2023.
//

import Foundation

// MARK: - NetworkManager
class NetworkManager {
    
    // MARK: - Public methods
    func fetchData(latitude: String, longitude: String, completionHandler: @escaping (Result<Forecast, Error>) -> Void) {
        if var components = URLComponents(string: Constants.NetworkManager.baseURL) {
            components.queryItems = [
                URLQueryItem(name: Constants.NetworkManager.latitude,
                             value: latitude),
                URLQueryItem(name: Constants.NetworkManager.longitude,
                             value: longitude),
                URLQueryItem(name: Constants.NetworkManager.appId,
                             value: Constants.NetworkManager.appIdValue),
                URLQueryItem(name: Constants.NetworkManager.units,
                             value:Constants.NetworkManager.metric)
            ]
            
            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completionHandler(.failure(error))
                    return
                }
                
                guard let data else {
                    print("Error: No data")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Forecast.self,
                                                      from: data)
                    completionHandler(.success(response))
                } catch {
                    completionHandler(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func fetchData(cityName: String, completionHandler: @escaping (Result<Forecast, Error>) -> Void) {
        if var components = URLComponents(string: Constants.NetworkManager.baseURL) {
            components.queryItems = [
                URLQueryItem(name: Constants.NetworkManager.q,
                             value: cityName),
                URLQueryItem(name: Constants.NetworkManager.appId,
                             value: Constants.NetworkManager.appIdValue),
                URLQueryItem(name: Constants.NetworkManager.units,
                             value: Constants.NetworkManager.metric)
            ]
            
            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completionHandler(.failure(error))
                    return
                }
                
                guard let data else {
                    print("Error: No data")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Forecast.self,
                                                      from: data)
                    completionHandler(.success(response))
                } catch {
                    completionHandler(.failure(error))
                }
            }
            task.resume()
        }
    }
}
