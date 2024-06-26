//
//  WeatherDetailRouterProtocol.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import UIKit

/// Протокол для маршрутизатора деталей погоды.
protocol WeatherDetailRouterProtocol: AnyObject {
    /// Создание модуля деталей погоды.
    /// - Parameters:
    ///   - city: Название города.
    ///   - networkManager: Менеджер сети.
    /// - Returns: ViewController модуля деталей погоды.
    static func createWeatherDetailModule(city: String, networkManager: NetworkManagingProtocol) -> UIViewController
}
