//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import Foundation

struct WeatherViewModel {
    let city: String
    let temperature: String
    let description: String
    let icon: String
    let forecast: [ForecastViewModel]
}

struct ForecastViewModel {
    let date: Date
    let temperature: String
    let description: String
    let icon: String
}

