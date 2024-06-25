//
//  WeatherDetailPresenter.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import Foundation

final class WeatherDetailPresenter: WeatherDetailPresenterProtocol {
    // MARK: - Public properties
    weak var view: WeatherDetailViewProtocol?
    var interactor: WeatherDetailInteractorInputProtocol?
    var router: WeatherDetailRouterProtocol?

    // MARK: - Private properties
    private enum Constants {
        static let defaultForecastDays = 3
    }

    // MARK: - Public Methods
    func viewDidLoad() {
        interactor?.fetchWeatherDetails()
        interactor?.fetchForecast(days: Constants.defaultForecastDays)
    }

    func didChangeForecastPeriod(to days: Int) {
        interactor?.fetchForecast(days: days)
    }
}

// MARK: - WeatherDetailInteractorOutputProtocol
extension WeatherDetailPresenter: WeatherDetailInteractorOutputProtocol {
    func didFetchCurrentWeather(_ weatherData: CityWeather) {
        let weatherViewModel = WeatherViewModel(
            city: weatherData.name,
            temperature: "\(Int(weatherData.main.temp.rounded()))°C",
            description: weatherData.weather.first?.description.capitalized ?? "",
            icon: weatherData.weather.first?.icon ?? "",
            forecast: []
        )
        view?.showWeatherDetails(weatherViewModel)
    }

    func didFetchForecast(_ forecastData: [ForecastViewModel]) {
        view?.showForecast(forecastData)
    }

    func didFailWithError(_ error: Error) {
        view?.showError(error.localizedDescription)
    }
}
