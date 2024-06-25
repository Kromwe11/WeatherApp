//
//  SearchResultsController.swift
//  WeatherApp
//
//  Created by Висент Щепетков on 25.06.2024.
//

import UIKit

/// Делегат для обработки выбора города из результатов поиска.
protocol SearchResultsControllerDelegate: AnyObject {
    /// Метод, вызываемый при выборе города.
    /// - Parameter city: Название выбранного города.
    func didSelectCity(_ city: String)
}

final class SearchResultsController: UITableViewController {
    // MARK: - Public properties
    weak var delegate: SearchResultsControllerDelegate?
    
    // MARK: - Private properties
    private var suggestedCities: [String] = []
    private var networkManager: NetworkManagingProtocol?
    
    private enum Constants {
        static let cellIdentifier = "SuggestionCell"
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    // MARK: - Public Methods
    func configure(networkManager: NetworkManagingProtocol) {
        self.networkManager = networkManager
    }
}

// MARK: - UITableViewDataSource
extension SearchResultsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestedCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        cell.textLabel?.text = suggestedCities[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchResultsController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = suggestedCities[indexPath.row]
        delegate?.didSelectCity(city)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UISearchResultsUpdating
extension SearchResultsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            suggestedCities = []
            tableView.reloadData()
            return
        }
        
        networkManager?.fetchSuggestedCities(for: searchText) { [weak self] cities in
            self?.suggestedCities = cities
            self?.tableView.reloadData()
        }
    }
}
