//
//  ContentView.swift
//  WeatherApp
//
//  Created by Pavlo Myroshnychenko on 19.05.2023.
//

import SwiftUI

// MARK: - ContentView
struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                if locationManager.location != nil {
                    WeatherView()
                        .environmentObject(locationManager)
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
    }
    
    // MARK: - Preview
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
