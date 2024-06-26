//
//  WeatherDetailPresenter.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import UIKit

final class WeatherDetailPresenter: WeatherDetailPresenterProtocol {

    // MARK: - Private properties
    private enum Constants {
        static let defaultForecastDays = 3
    }
    private weak var view: WeatherDetailPresenterOutput?
    private var interactor: WeatherDetailInteractorInputProtocol?
    private var router: WeatherDetailRouterProtocol?

    // MARK: - Public Methods
    func viewDidLoad() {
        interactor?.fetchWeatherDetails()
        interactor?.fetchForecast(days: Constants.defaultForecastDays)
    }

    func didChangeForecastPeriod(to days: Int) {
        interactor?.fetchForecast(days: days)
    }
    
    func loadImage(for icon: String, completion: @escaping (UIImage?) -> Void) {
        interactor?.loadImage(for: icon, completion: completion)
    }

    // MARK: - Configuration
    func configure(
        view: WeatherDetailPresenterOutput,
        interactor: WeatherDetailInteractorInputProtocol,
        router: WeatherDetailRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
        self.view = view
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
