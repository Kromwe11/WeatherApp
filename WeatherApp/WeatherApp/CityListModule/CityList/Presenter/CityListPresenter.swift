//
//  CityListPresenter.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import Foundation

final class CityListPresenter: CityListPresenterProtocol {
    // MARK: - Public properties
    weak var view: CityListPresenterOutput?
    var interactor: CityListInteractorInputProtocol?
    var router: CityListRouterProtocol?
    var networkManager: NetworkManagingProtocol?
    
    // MARK: - Private properties
    private var cities: [String] = []
    private var weatherData: [String: CityWeather] = [:]
    private var loadingCities: Set<String> = []
    
    // MARK: - Configuration
    func configure(
        view: CityListPresenterOutput,
        interactor: CityListInteractorInputProtocol,
        router: CityListRouterProtocol,
        networkManager: NetworkManagingProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.networkManager = networkManager
    }
    
    // MARK: - Public Methods
    func viewDidLoad() {
        interactor?.fetchCities()
    }
    
    func didSelectCity(_ city: String) {
        guard let weather = weatherData[city] else { return }
        router?.navigateToWeatherDetail(from: view!, for: city, with: weather)
    }
    
    func didSearchCity(_ query: String) {
        interactor?.searchCities(query: query)
    }
    
    func didAddCity(_ city: String, isInitialLoad: Bool = false) {
        let cleanedCity = cleanCityName(city)
        guard !cities.contains(cleanedCity) else { return }
        guard !loadingCities.contains(cleanedCity) else { return }
        loadingCities.insert(cleanedCity)
        
        if isInitialLoad {
            cities.append(cleanedCity)
        }
        
        interactor?.fetchWeather(for: cleanedCity)
    }
    
    func didDeleteCity(at index: Int) {
        let city = cities.remove(at: index)
        weatherData.removeValue(forKey: city)
        updateView()
    }
    
    // MARK: - Private Methods
    private func updateView() {
        let cityWeatherModels = cities.compactMap { weatherData[$0] }
        view?.showCities(cityWeatherModels)
    }
    
    private func cleanCityName(_ city: String) -> String {
        return city.components(separatedBy: ",").first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? city
    }
}

// MARK: - CityListInteractorOutputProtocol
extension CityListPresenter: CityListInteractorOutputProtocol {
    func didFetchCities(_ cities: [String]) {
        let cleanedCities = cities.map { cleanCityName($0) }
        for city in cleanedCities {
            didAddCity(city, isInitialLoad: true)
        }
    }
    
    func didFetchWeather(for city: String, weather: CityWeather) {
        let cleanedCity = cleanCityName(city)
        weatherData[cleanedCity] = weather
        loadingCities.remove(cleanedCity)
        if !cities.contains(cleanedCity) {
            cities.append(cleanedCity)
        }
        updateView()
    }
    
    func didFailWithError(_ error: Error) {
        view?.showError(error.localizedDescription)
    }
}
