//
//  ForecastData.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import Foundation

struct ForecastData: Codable {
    let list: [Forecast]
}

struct Forecast: Codable {
    let dt: TimeInterval
    let main: Main
    let weather: [Weather]
}

