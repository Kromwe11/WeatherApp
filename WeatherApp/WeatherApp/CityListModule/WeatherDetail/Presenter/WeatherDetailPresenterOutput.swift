//
//  WeatherDetailPresenterOutput.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import Foundation

/// Протокол для представления деталей погоды.
protocol WeatherDetailPresenterOutput: AnyObject {
    /// Показать подробную информацию о погоде.
    /// - Parameter weatherDetails: Модель данных о погоде.
    func showWeatherDetails(_ weatherDetails: WeatherViewModel)
    
    /// Показать прогноз погоды.
    /// - Parameter forecast: Массив моделей данных прогноза.
    func showForecast(_ forecast: [ForecastViewModel])
    
    /// Показать сообщение об ошибке.
    /// - Parameter message: Сообщение об ошибке.
    func showError(_ message: String)
}
