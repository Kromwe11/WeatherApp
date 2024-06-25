//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import UIKit

final class ForecastTableViewCell: UITableViewCell {
    // MARK: - Public properties
    let dateLabel = UILabel()
    let temperatureLabel = UILabel()
    let descriptionLabel = UILabel()
    let weatherIconImageView = UIImageView()
    
    // MARK: - Private properties
    private var isConfigured = false
    
    private enum Constants {
        static let dateFontSize: CGFloat = 16
        static let temperatureFontSize: CGFloat = 18
        static let descriptionFontSize: CGFloat = 14
        static let cornerRadius: CGFloat = 8
        static let weatherIconSize: CGFloat = 40
        static let padding: CGFloat = 15
        static let interItemSpacing: CGFloat = 5
        static let backgroundColor: UIColor = UIColor(white: 0.9, alpha: 1)
        static let iconUrlPrefix = "https://openweathermap.org/img/wn/"
        static let iconUrlSuffix = "@2x.png"
    }
    
    // MARK: - Public Methods
    func configure(date: String, temperature: String, description: String, icon: String) {
        if !isConfigured {
            setupViews()
            layoutViews()
            isConfigured = true
        }
        
        dateLabel.text = date
        temperatureLabel.text = temperature
        descriptionLabel.text = description.capitalized
        let iconUrl = URL(string: "\(Constants.iconUrlPrefix)\(icon)\(Constants.iconUrlSuffix)")!
        weatherIconImageView.load(url: iconUrl)
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        setupDateLabel()
        setupTemperatureLabel()
        setupDescriptionLabel()
        setupWeatherIconImageView()
        setupContentView()
    }
    
    private func setupDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.systemFont(ofSize: Constants.dateFontSize)
        dateLabel.textColor = .darkGray
        contentView.addSubview(dateLabel)
    }
    
    private func setupTemperatureLabel() {
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: Constants.temperatureFontSize)
        temperatureLabel.textColor = .black
        contentView.addSubview(temperatureLabel)
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupWeatherIconImageView() {
        weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherIconImageView.contentMode = .scaleAspectFit
        contentView.addSubview(weatherIconImageView)
    }
    
    private func setupContentView() {
        contentView.backgroundColor = Constants.backgroundColor
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.layer.masksToBounds = true
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            weatherIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            weatherIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: Constants.weatherIconSize),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: Constants.weatherIconSize),
            
            dateLabel.leadingAnchor.constraint(equalTo: weatherIconImageView.trailingAnchor, constant: Constants.padding),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            
            temperatureLabel.leadingAnchor.constraint(equalTo: weatherIconImageView.trailingAnchor, constant: Constants.padding),
            temperatureLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Constants.interItemSpacing),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: Constants.interItemSpacing),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding)
        ])
    }
}
