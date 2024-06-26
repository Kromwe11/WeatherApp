//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import Foundation

struct CityWeather: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}
