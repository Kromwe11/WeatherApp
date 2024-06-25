//
//  WeatherDetailPresenterProtocol.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import Foundation

/// Протокол для презентера деталей погоды.
protocol WeatherDetailPresenterProtocol: AnyObject {
    /// Обработка события загрузки представления.
    func viewDidLoad()
    
    /// Обработка изменения периода прогноза.
    /// - Parameter days: Количество дней прогноза.
    func didChangeForecastPeriod(to days: Int)
}
