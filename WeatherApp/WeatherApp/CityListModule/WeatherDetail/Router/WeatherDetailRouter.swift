//
// WeatherDetailRouter.swift
// WeatherApp
//
// Created by Висент Щепетков on 25.06.2024.
//

import UIKit

final class WeatherDetailRouter: WeatherDetailRouterProtocol {
    
    // MARK: Public Methods
    static func createWeatherDetailModule(city: String, networkManager: NetworkManagingProtocol) -> UIViewController {
        let view = WeatherDetailViewController()
        let interactor = WeatherDetailInteractor()
        let presenter = WeatherDetailPresenter()
        let router = WeatherDetailRouter()
        let imageLoadingService = ImageLoadingService()
        
        view.configure(presenter: presenter)
        presenter.configure(view: view, interactor: interactor, router: router)
        interactor.configure(
            city: city,
            networkManager: networkManager,
            presenter: presenter,
            imageLoadingService: imageLoadingService
        )
        
        return view
    }
}
