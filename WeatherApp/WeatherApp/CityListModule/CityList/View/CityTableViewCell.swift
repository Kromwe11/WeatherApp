//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import UIKit

final class CityTableViewCell: UITableViewCell {
    // MARK: - Private properties
    private let cityLabel = UILabel()
    private let temperatureLabel = UILabel()
    private var isConfigured = false
    
    private enum Constants {
        static let leadingPadding: CGFloat = 15
        static let trailingPadding: CGFloat = -15
    }
    
    // MARK: - Public Methods
    func configure(city: String, temperature: String?) {
        if !isConfigured {
            setupViews()
            layoutViews()
            isConfigured = true
        }
        cityLabel.text = city
        temperatureLabel.text = temperature
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(cityLabel)
        contentView.addSubview(temperatureLabel)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingPadding),
            cityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingPadding),
            temperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
