//
//  NetworkManaging.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import Alamofire

final class NetworkManager: NetworkManagingProtocol {
    // MARK: - Constants
    private enum Constants {
        static let apiKey = "43887baaec0022d4b7744d2498f8907c"
        static let weatherBaseUrl = "https://api.openweathermap.org/data/2.5/weather"
        static let forecastBaseUrl = "https://api.openweathermap.org/data/2.5/forecast"
        static let geocodingBaseUrl = "https://api.openweathermap.org/geo/1.0/direct"
        static let metricUnits = "metric"
        static let geocodingLimit = 5
    }
    
    // MARK: - Public Methods
    func getWeather(for city: String, completion: @escaping (CityWeather?) -> Void) {
        let url = "\(Constants.weatherBaseUrl)?q=\(city)&appid=\(Constants.apiKey)&units=\(Constants.metricUnits)"
        AF.request(url).responseDecodable(of: CityWeather.self) { response in
            switch response.result {
            case .success(let weatherData):
                completion(weatherData)
            case .failure:
                completion(nil)
            }
        }
    }

    func getForecast(for city: String, days: Int, completion: @escaping (ForecastData?) -> Void) {
        let url = "\(Constants.forecastBaseUrl)?q=\(city)&cnt=\(days * 8)&appid=\(Constants.apiKey)&units=\(Constants.metricUnits)"
        
        AF.request(url).responseDecodable(of: ForecastData.self) { response in
            switch response.result {
            case .success(let forecastData):
                completion(forecastData)
            case .failure:
                completion(nil)
            }
        }
    }

    func fetchSuggestedCities(for query: String, completion: @escaping ([String]) -> Void) {
        let url = "\(Constants.geocodingBaseUrl)?q=\(query)&limit=\(Constants.geocodingLimit)&appid=\(Constants.apiKey)"
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let jsonArray = value as? [[String: Any]] {
                    let cities = jsonArray.compactMap { dict -> String? in
                        if let name = dict["name"] as? String, let country = dict["country"] as? String {
                            return "\(name), \(country)"
                        }
                        return nil
                    }
                    completion(cities)
                } else {
                    completion([])
                }
            case .failure:
                completion([])
            }
        }
    }
}
