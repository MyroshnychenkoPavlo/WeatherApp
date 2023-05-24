//
//  DateFormater.swift
//  WeatherApp
//
//  Created by Pavlo Myroshnychenko on 22.05.2023.
//

import Foundation

// MARK: - DateFormater
final class MyDateFormater {
    
    // MARK: - Public methods
    func convertToDayWithTime(date: Int) -> String {
        let timeInterval = TimeInterval(date)
        let myDate = Date(timeIntervalSince1970: timeInterval)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd EEE HH:mm"
        
        return formatter.string(from: myDate)
    }
    
    func convertToTime(date: Int) -> String? {
        let timeInterval = TimeInterval(date)
        let myDate = Date(timeIntervalSince1970: timeInterval)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: myDate)
    }
    
    func convertToDay(date: Int) -> String {
        let timeInterval = TimeInterval(date)
        let myDate = Date(timeIntervalSince1970: timeInterval)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd EEE"
        
        return formatter.string(from: myDate)
    }
    
    func convertToDate(day: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd EEE"
        return formatter.date(from: day) ?? Date()
    }
    
}
