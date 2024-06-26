//
//  WeatherDetailPresenterProtocol.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import UIKit

/// Протокол для презентера деталей погоды.
protocol WeatherDetailPresenterProtocol: AnyObject {
    /// Обработка события загрузки представления.
    func viewDidLoad()
    
    /// Обработка изменения периода прогноза.
    /// - Parameter days: Количество дней прогноза.
    func didChangeForecastPeriod(to days: Int)
    
    /// Загрузить изображение для иконки погоды.
    /// - Parameter icon: Название иконки.
    /// - Parameter completion: Замыкание с результатом загрузки изображения.
    func loadImage(for icon: String, completion: @escaping (UIImage?) -> Void)
}
