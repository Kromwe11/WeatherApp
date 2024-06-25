//
//  CityListPresenterProtocol.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import Foundation

/// Протокол, определяющий методы для управления представлением списка городов.
protocol CityListPresenterProtocol: AnyObject {
    /// Менеджер сетевых запросов.
    var networkManager: NetworkManagingProtocol? { get set }
    
    /// Вызывается при загрузке представления.
    func viewDidLoad()
    
    /// Вызывается при выборе города.
    /// - Parameter city: Название выбранного города.
    func didSelectCity(_ city: String)
    
    /// Вызывается при поиске города.
    /// - Parameter query: Поисковой запрос.
    func didSearchCity(_ query: String)
    
    /// Вызывается при добавлении нового города.
    /// - Parameters:
    ///   - city: Название добавляемого города.
    ///   - isInitialLoad: Флаг, указывающий на первоначальную загрузку.
    func didAddCity(_ city: String, isInitialLoad: Bool)
    
    /// Вызывается при удалении города.
    /// - Parameter index: Индекс удаляемого города.
    func didDeleteCity(at index: Int)
}
