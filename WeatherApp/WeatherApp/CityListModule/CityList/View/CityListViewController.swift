//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import UIKit

final class CityListViewController: UIViewController {
    
    // MARK: - Private properties
    private var cities: [CityWeather] = []
    private let tableView = UITableView()
    private enum Constants {
        static let title = "Weather"
        static let addBarButtonItem = UIBarButtonItem.SystemItem.add
        static let cellIdentifier = "CityCell"
        static let errorTitle = "Error"
        static let okActionTitle = "OK"
    }
    private var presenter: CityListPresenterProtocol?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        presenter?.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deselectAllRows()
    }
    // MARK: - Configuration
    func configure(presenter: CityListPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        title = Constants.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: Constants.addBarButtonItem,
            target: self,
            action: #selector(promptForCity)
        )
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func deselectAllRows() {
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
            for indexPath in selectedIndexPaths {
                tableView.deselectRow(at: indexPath, animated: false)
            }
        }
    }
    
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Actions
    @objc private func promptForCity() {
        guard let networkManager = presenter?.networkManager else { return }
        let searchResultsController = SearchResultsController()
        searchResultsController.configure(networkManager: networkManager)
        searchResultsController.delegate = self
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController
        searchController.obscuresBackgroundDuringPresentation = false
        present(searchController, animated: true, completion: nil)
    }
}

// MARK: - CityListPresenterOutput
extension CityListViewController: CityListPresenterOutput {
    func showCities(_ cities: [CityWeather]) {
        self.cities = cities
        tableView.reloadData()
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: Constants.errorTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.okActionTitle, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension CityListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIdentifier,
            for: indexPath
        ) as? CityTableViewCell else {
            return UITableViewCell()
        }
        
        let cityWeather = cities[indexPath.row]
        let temperature = "\(Int(cityWeather.main.temp.rounded()))°C"
        cell.configure(city: cityWeather.name, temperature: temperature)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CityListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityWeather = cities[indexPath.row]
        presenter?.didSelectCity(cityWeather.name)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.didDeleteCity(at: indexPath.row)
        }
    }
}

// MARK: - SearchResultsControllerDelegate
extension CityListViewController: SearchResultsControllerDelegate {
    func didSelectCity(_ city: String) {
        presenter?.didAddCity(city, isInitialLoad: false)
    }
}
