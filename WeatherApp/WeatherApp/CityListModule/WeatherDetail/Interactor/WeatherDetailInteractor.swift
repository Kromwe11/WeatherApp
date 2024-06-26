//
// WeatherDetailInteractor.swift
// WeatherApp
//
// Created by Висент Щепетков on 25.06.2024.
//

import UIKit

final class WeatherDetailInteractor: WeatherDetailInteractorInputProtocol {
        
    // MARK: - Private properties
    private var networkManager: NetworkManagingProtocol?
    private var city: String?
    private weak var presenter: WeatherDetailInteractorOutputProtocol?
    private var imageLoadingService: ImageLoadingServiceProtocol?

    private enum Constants {
        static let weatherErrorDomain = "WeatherDetailInteractor"
        static let weatherErrorCode = 1
        static let weatherErrorMessage = "Не удалось получить данные о погоде"
        static let forecastErrorMessage = "Не удалось получить данные о прогнозе"
        static let iconUrlPrefix = "https://openweathermap.org/img/wn/"
        static let iconUrlSuffix = "@2x.png"
    }
    
    // MARK: - Configuration
    func configure(city: String, networkManager: NetworkManagingProtocol, presenter: WeatherDetailInteractorOutputProtocol, imageLoadingService: ImageLoadingServiceProtocol) {
        self.city = city
        self.networkManager = networkManager
        self.presenter = presenter
        self.imageLoadingService = imageLoadingService
    }
    
    // MARK: - Public Methods
    func fetchWeatherDetails() {
        guard let city = city, let networkManager = networkManager else { return }
        networkManager.getWeather(for: city) { [weak self] weatherData in
            guard let self = self else { return }
            if let weatherData = weatherData {
                self.presenter?.didFetchCurrentWeather(weatherData)
            } else {
                self.presenter?.didFailWithError(NSError(
                    domain: Constants.weatherErrorDomain,
                    code: Constants.weatherErrorCode,
                    userInfo: [NSLocalizedDescriptionKey: Constants.weatherErrorMessage]
                ))
            }
        }
    }
    
    func fetchForecast(days: Int) {
        guard let city = city, let networkManager = networkManager else { return }
        networkManager.getForecast(for: city, days: days) { [weak self] forecastData in
            guard let self = self else { return }
            if let forecastData = forecastData {
                let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!.startOfDay
                let groupedForecasts = Dictionary(
                    grouping: forecastData.list, by: { Date(timeIntervalSince1970: $0.dt).startOfDay }
                )
                let filteredForecasts = groupedForecasts.compactMap { (key, value) -> ForecastViewModel? in
                    guard key >= tomorrow else { return nil }
                    guard let forecast = value.first(where: { Calendar.current.component(.hour, from: Date(timeIntervalSince1970: $0.dt)) == 12 }) ?? value.max(by: { $0.main.temp < $1.main.temp }) else {
                        return nil
                    }
                    return ForecastViewModel(
                        date: key,
                        temperature: "\(Int(forecast.main.temp.rounded()))°C",
                        description: forecast.weather.first?.description.capitalized ?? "",
                        icon: forecast.weather.first?.icon ?? ""
                    )
                }
                self.presenter?.didFetchForecast(filteredForecasts.sorted(by: { $0.date < $1.date }))
            } else {
                self.presenter?.didFailWithError(NSError(
                    domain: Constants.weatherErrorDomain,
                    code: Constants.weatherErrorCode,
                    userInfo: [NSLocalizedDescriptionKey: Constants.forecastErrorMessage]
                ))
            }
        }
    }
    
    func loadImage(for icon: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageLoadingService = imageLoadingService else {
            completion(nil)
            return
        }
        let iconUrl = URL(string: "\(Constants.iconUrlPrefix)\(icon)\(Constants.iconUrlSuffix)")!
        imageLoadingService.loadImage(from: iconUrl, completion: completion)
    }
}
