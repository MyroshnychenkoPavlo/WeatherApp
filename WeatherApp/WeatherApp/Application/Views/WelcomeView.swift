//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Pavlo Myroshnychenko on 21.05.2023.
//

import SwiftUI
import CoreLocationUI

// MARK: - WelcomeView
struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    // MARK: - Body
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(spacing: 10) {
                    Text("Weather App")
                        .bold().font(.title)
                    Text("Please share your current location :)")
                }
                .multilineTextAlignment(.center)
                .padding()
                
                LocationButton(.shareCurrentLocation) {
                    locationManager.requestLocation()
                }
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// MARK: - Preview
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
