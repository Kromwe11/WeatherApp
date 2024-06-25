//
//  CityListInteractorProtocol.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import Foundation

/// Протокол, определяющий методы для взаимодействия с сетевыми запросами.
protocol CityListInteractorInputProtocol: AnyObject {
    /// Извлекает список городов.
    func fetchCities()
    
    /// Извлекает данные о погоде для указанного города.
    /// - Parameter city: Название города.
    func fetchWeather(for city: String)
    
    /// Выполняет поиск городов по запросу.
    /// - Parameter query: Поисковой запрос.
    func searchCities(query: String)
}

/// Протокол, определяющий методы для получения данных от интерактора.
protocol CityListInteractorOutputProtocol: AnyObject {
    /// Вызывается при успешном получении списка городов.
    /// - Parameter cities: Массив названий городов.
    func didFetchCities(_ cities: [String])
    
    /// Вызывается при успешном получении данных о погоде для города.
    /// - Parameters:
    ///   - city: Название города.
    ///   - weather: Данные о погоде для города.
    func didFetchWeather(for city: String, weather: CityWeather)
    
    /// Вызывается при возникновении ошибки.
    /// - Parameter error: Ошибка, возникшая при выполнении запроса.
    func didFailWithError(_ error: Error)
}
