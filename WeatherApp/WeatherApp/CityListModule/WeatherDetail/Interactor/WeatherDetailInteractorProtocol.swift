//
//  WeatherDetailInteractorProtocol.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import UIKit

/// Протокол для интерактора входящих данных деталей погоды.
protocol WeatherDetailInteractorInputProtocol: AnyObject {
    /// Получить подробную информацию о погоде.
    func fetchWeatherDetails()
    
    /// Получить прогноз погоды.
    /// - Parameter days: Количество дней прогноза.
    func fetchForecast(days: Int)
    
    /// Загрузить изображение для иконки погоды.
    /// - Parameter icon: Название иконки.
    /// - Parameter completion: Замыкание с результатом загрузки изображения.
    func loadImage(for icon: String, completion: @escaping (UIImage?) -> Void)
}

/// Протокол для интерактора выходящих данных деталей погоды.
protocol WeatherDetailInteractorOutputProtocol: AnyObject {
    /// Обработка успешного получения данных о текущей погоде.
    /// - Parameter weatherData: Модель данных о погоде.
    func didFetchCurrentWeather(_ weatherData: CityWeather)
    
    /// Обработка успешного получения данных прогноза.
    /// - Parameter forecastData: Массив моделей данных прогноза.
    func didFetchForecast(_ forecastData: [ForecastViewModel])
    
    /// Обработка ошибки при получении данных.
    /// - Parameter error: Ошибка.
    func didFailWithError(_ error: Error)
}
