//
//  CityListViewProtocol.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import Foundation

/// Протокол, определяющий методы для обновления представления списка городов.
protocol CityListViewProtocol: AnyObject {
    /// Отображает список городов с данными о погоде.
    /// - Parameter cities: Массив данных о погоде для городов.
    func showCities(_ cities: [CityWeather])
    
    /// Отображает сообщение об ошибке.
    /// - Parameter message: Текст сообщения об ошибке.
    func showError(_ message: String)
}
