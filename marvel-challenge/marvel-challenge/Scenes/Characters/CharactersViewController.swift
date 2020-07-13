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
    func displayError(_ error: Characters.Error)
}

class CharactersViewController: UITableViewController {
    
    var interactor: CharactersBusinessLogic?
    var router: (NSObjectProtocol & CharactersRoutingLogic & CharactersDataPassing)?
    
    // MARK: Constants
    
    let cellReuseIdentifier = String(describing: UITableViewCell.self)
    
    // MARK: Variables
    var viewModel: Characters.GetCharacters.ViewModel?
    
    // MARK: Computed Propierties
    
    var isSearching: Bool {
        return searchController.searchBar.text?.isEmpty ?? false
    }
    
    var searchedCharacters: [Characters.DisplayedCharacter] {
        guard let viewModel = viewModel else { return [] }
        let searchText = searchController.searchBar.text ?? ""
        let options: String.CompareOptions = [.caseInsensitive, .diacriticInsensitive]
        let searchedCharacters = viewModel.displayedCharacters.filter { (character) -> Bool in
            return character.name.range(of: searchText, options: options) != nil
        }
        return searchedCharacters
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
}

// MARK: Display Logic

extension CharactersViewController: CharactersDisplayLogic {
    
    func displayCharacters(viewModel: Characters.GetCharacters.ViewModel) {
        loadingActivityIndicator.stopAnimating()
        self.viewModel = viewModel
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
            return viewModel?.displayedCharacters.count ?? 0
        } else {
            return searchedCharacters.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        let displayedCharacter: Characters.DisplayedCharacter = {
            if isSearching {
                return viewModel.displayedCharacters[indexPath.row]
            } else {
                return searchedCharacters[indexPath.row]
            }
        }()
        
        cell.textLabel?.text = displayedCharacter.name
        
        return cell
    }
    
    //MARK: Swipe Action
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let handler: UIContextualAction.Handler = { (action, sourceView, completion) in
            
        }
        let action = FavoriteContextualAction(handler: handler)
        action.isFavorite = false
        let swipeActionsConfiguration = UISwipeActionsConfiguration(actions: [action])
        swipeActionsConfiguration.performsFirstActionWithFullSwipe = true
        return swipeActionsConfiguration
    }
}

// MARK: UISearchController Delegate

extension CharactersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
    }
}
