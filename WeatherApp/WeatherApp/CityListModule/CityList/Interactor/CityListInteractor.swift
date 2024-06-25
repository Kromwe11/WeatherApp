//
//  CityListInteractor.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import Foundation

final class CityListInteractor: CityListInteractorInputProtocol {
    
    // MARK: - Public properties
    weak var presenter: CityListInteractorOutputProtocol?
    
    // MARK: - Private properties
    private var networkManager: NetworkManagingProtocol?
    
    // MARK: - Configuration
    func configure(presenter: CityListInteractorOutputProtocol, networkManager: NetworkManagingProtocol) {
        self.presenter = presenter
        self.networkManager = networkManager
    }
    
    // MARK: - Public Methods
    func fetchCities() {
        let defaultCities = ["Moscow", "Perm"]
        presenter?.didFetchCities(defaultCities)
    }
    
    func fetchWeather(for city: String) {
        networkManager?.getWeather(for: city) { [weak self] (weatherData: CityWeather?) in
            guard let self = self else { return }
            if let weatherData = weatherData {
                self.presenter?.didFetchWeather(for: city, weather: weatherData)
            } else {
                self.presenter?.didFailWithError(
                    NSError(
                        domain: "CityListInteractor",
                        code: 1,
                        userInfo: [NSLocalizedDescriptionKey: "Не удалось получить данные о погоде"]
                    )
                )
            }
        }
    }
    
    func searchCities(query: String) {
        networkManager?.fetchSuggestedCities(for: query) { [weak self] cities in
            self?.presenter?.didFetchCities(cities)
        }
    }
}
