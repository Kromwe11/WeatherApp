//
//  CityListRouter.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import UIKit

final class CityListRouter: CityListRouterProtocol {
    
    // MARK: - Public properties
    weak var viewController: UIViewController?
    
    // MARK: - Public Methods
    static func createCityListModule() -> UIViewController {
        let networkManager = NetworkManager()
        let view = CityListViewController()
        let interactor = CityListInteractor()
        let presenter = CityListPresenter()
        let router = CityListRouter()
        
        view.presenter = presenter
        presenter.configure(view: view, interactor: interactor, router: router, networkManager: networkManager)
        interactor.configure(presenter: presenter, networkManager: networkManager)
        router.viewController = view
        
        return view
    }
    
    func navigateToWeatherDetail(from view: CityListViewProtocol, for city: String, with weatherData: CityWeather) {
        let weatherDetailViewController = WeatherDetailRouter.createWeatherDetailModule(city: city, networkManager: NetworkManager())
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(weatherDetailViewController, animated: true)
        }
    }
}
