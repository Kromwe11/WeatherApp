//
//  CityListRouterProtocol.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import UIKit

/// Протокол, определяющий методы для навигации из списка городов.
protocol CityListRouterProtocol: AnyObject {
    /// Создает модуль списка городов.
    /// - Returns: Представление контроллера списка городов.
    static func createCityListModule() -> UIViewController
    
    /// Выполняет навигацию к экрану с деталями погоды для города.
    /// - Parameters:
    ///   - view: Представление, из которого выполняется навигация.
    ///   - city: Название города.
    ///   - weatherData: Данные о погоде для города.
    func navigateToWeatherDetail(from view: CityListPresenterOutput, for city: String, with weatherData: CityWeather)
}
