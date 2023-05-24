//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Pavlo Myroshnychenko on 20.05.2023.
//

import SwiftUI
import CoreLocation
import Kingfisher

// MARK: - WeatherView
struct WeatherView: View {
    // MARK: - EnvironmentObject
    @EnvironmentObject var locationManager: LocationManager
    
    // MARK: - StateObject
    @StateObject private var weatherViewModel = WeatherViewModel()
    
    // MARK: - Private propertie
    @State private var location: String = ""
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                TextField("Search another city", text: $weatherViewModel.locationService.queryFragment)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(5)
                Button {
                    weatherViewModel.locationTapped(location: weatherViewModel.locationService.queryFragment)
                } label: {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.title3)
                }
                .disabled(weatherViewModel.locationService.queryFragment.isEmpty)
            } .padding([.leading, .trailing], 20)
            HStack {
                Text((weatherViewModel.response?.city.name ?? ""))
                    .bold().font(.title)
            }
            
            SwiftUI.List {
                ForEach($weatherViewModel.daysWeather, id: \.id) { $day in
                    NavigationLink(destination: {
                        detailedWeatherList(data: weatherViewModel.detailedWeather(for: day.title))
                    }, label: {
                        VStack(alignment: .leading) {
                            Text(day.title)
                                .fontWeight(.bold)
                            HStack(alignment: .top) {
                                KFImage(weatherViewModel.weatherIconURL(for: day.weatherIcon))
                                Text("Average temp: \(day.averageTemperature)°")
                                    .fontWeight(.bold)
                                    .padding(.top, 13)
                            }
                        }
                    })
                }
            } .listStyle(.plain)
        } .onAppear {
            weatherViewModel.onAppear(location: locationManager.location)
        }
    }
    
    // MARK: - Private method
    @ViewBuilder private func detailedWeatherList(data: [List]) -> some View {
        SwiftUI.List {
            ForEach(data, id: \.dt) { day in
                VStack(alignment: .leading) {
                    Text(MyDateFormater().convertToDayWithTime(date: day.dt))
                        .fontWeight(.bold)
                    HStack(alignment: .top) {
                        KFImage(weatherViewModel.weatherIconURL(for: day.weather.first?.icon ?? ""))
                        VStack(alignment: .leading) {
                            Text(day.weather[0].description)
                            HStack {
                                Text("High: \(day.main.tempMax, specifier: "%.0f")°")
                                Text("Low: \(day.main.tempMin, specifier: "%.0f")°")
                            }
                            Text("Humidity: \(day.main.humidity)%")
                        }
                    }
                }
            }
        } .listStyle(.plain)
    }
}

// MARK: - Preview
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
