//
//  CharactersViewController.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright (c) 2020 danilo. All rights reserved.

import UIKit
import NVActivityIndicatorView

protocol CharactersDisplayLogic: AnyObject {
    func displayCharacters(viewModel: Characters.GetCharacters.ViewModel)
    func displaySearchedCharacters(viewModel: Characters.SearchCharacters.ViewModel)
    func displayError(_ error: Characters.Error)
}

class CharactersViewController: UITableViewController {
    
    var interactor: CharactersBusinessLogic?
    var router: (NSObjectProtocol & CharactersRoutingLogic & CharactersDataPassing)?
    
    // MARK: Constants
    
    let cellReuseIdentifier = String(describing: UITableViewCell.self)
    
    // MARK: Variables
    
    var viewModel: Characters.GetCharacters.ViewModel?
    var searchedViewModel: Characters.SearchCharacters.ViewModel?
    
    // MARK: Computed Propierties
    
    var isSearching: Bool {
        let searchText = searchController.searchBar.text ?? ""
        return !searchText.isEmpty
    }
    
    // MARK: UI Elements
    
    lazy var loadingActivityIndicator = NVActivityIndicatorView(frame: view.frame, type: .ballRotateChase, color: .red)
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        return searchController
    }()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestCharacters()
    }
    
    // MARK: Private Functions
    
    private func setupUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        navigationItem.searchController = searchController
        title = "Hérois"
        view.addSubview(loadingActivityIndicator)
        
    }
    
    private func requestCharacters() {
        loadingActivityIndicator.startAnimating()
        interactor?.requestCharacters()
    }
    
    private func getDisplayedCharacter(at indexPath: IndexPath) -> Characters.DisplayedCharacter? {
        if isSearching {
            return searchedViewModel?.displayedCharacters[indexPath.row]
        } else {
            return viewModel?.displayedCharacters[indexPath.row]
        }
    }
}

// MARK: Display Logic

extension CharactersViewController: CharactersDisplayLogic {
    
    func displayCharacters(viewModel: Characters.GetCharacters.ViewModel) {
        loadingActivityIndicator.stopAnimating()
        self.viewModel = viewModel
        tableView.reloadData()
    }
    
    func displaySearchedCharacters(viewModel: Characters.SearchCharacters.ViewModel) {
        self.searchedViewModel = viewModel
        tableView.reloadData()
    }
    
    func displayError(_ error: Characters.Error) {
        loadingActivityIndicator.stopAnimating()
    }
    
}

// MARK: TableView Data Source

extension CharactersViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedViewModel?.displayedCharacters.count ?? 0
        } else {
            return viewModel?.displayedCharacters.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let displayedCharacter = getDisplayedCharacter(at: indexPath)
        cell.textLabel?.text = displayedCharacter?.name
        return cell
    }
    
    //MARK: Swipe Action
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let displayedCharacter = getDisplayedCharacter(at: indexPath)
        
        let action = FavoriteContextualAction { (action, sourceView, completion) in
            let action = action as? FavoriteContextualAction
            action?.isFavorite = displayedCharacter?.isFavorited ?? false
            completion(true)
        }
        
        let swipeActionsConfiguration = UISwipeActionsConfiguration(actions: [action])
        return swipeActionsConfiguration
    }
}

// MARK: UISearchController Delegate

extension CharactersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        let request = Characters.SearchCharacters.Request(searchText: searchText)
        interactor?.searchCharacters(request: request)
    }
}
