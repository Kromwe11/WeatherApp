//
//  NetworkManagingProtocol.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import Foundation

/// Протокол для управления сетевыми запросами.
protocol NetworkManagingProtocol {
    /// Получает данные о погоде для указанного города.
    /// - Parameters:
    ///   - city: Название города.
    ///   - completion: Замыкание, вызываемое при завершении запроса. Возвращает объект `CityWeather` или nil в случае ошибки.
    func getWeather(for city: String, completion: @escaping (CityWeather?) -> Void)
    
    /// Получает список предложенных городов для указанного запроса.
    /// - Parameters:
    ///   - query: Поисковой запрос.
    ///   - completion: Замыкание, вызываемое при завершении запроса. Возвращает массив строк с предложенными городами.
    func fetchSuggestedCities(for query: String, completion: @escaping ([String]) -> Void)
    
    /// Получает прогноз погоды для указанного города на заданное количество дней.
    /// - Parameters:
    ///   - city: Название города.
    ///   - days: Количество дней для прогноза.
    ///   - completion: Замыкание, вызываемое при завершении запроса. Возвращает объект `ForecastData` или nil в случае ошибки.
    func getForecast(for city: String, days: Int, completion: @escaping (ForecastData?) -> Void)
}
