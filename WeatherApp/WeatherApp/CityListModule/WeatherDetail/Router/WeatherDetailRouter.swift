//
//  WeatherDetailRouter.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import UIKit

final class WeatherDetailRouter: WeatherDetailRouterProtocol {
    
    // MARK: Public Methods
    static func createWeatherDetailModule(city: String, networkManager: NetworkManagingProtocol) -> UIViewController {
        let view = WeatherDetailViewController()
        let interactor = WeatherDetailInteractor()
        let presenter = WeatherDetailPresenter()
        let router = WeatherDetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.configure(city: city, networkManager: networkManager)
        
        return view
    }
}
