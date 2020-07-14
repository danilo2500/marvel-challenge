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
    var dispatchWorkItem = DispatchWorkItem {}
    var viewModel: Characters.GetCharacters.ViewModel?
    
    // MARK: UI Elements
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
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
        title = "Hérois"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.keyboardDismissMode = .interactive
        navigationItem.searchController = searchController
    }
    
    private func requestCharacters() {
        LoadingView.show()
        interactor?.requestCharacters()
    }
    
    private func saveCharacterOnFavorite(at indexPath: IndexPath) {
        let request = Characters.SaveInFavorite.Request(indexPath: indexPath)
        interactor?.saveCharacterInFavorite(request: request)
    }
    
    private func searchCharacters() {
        let searchText = searchController.searchBar.text ?? ""
        let request = Characters.SearchCharacters.Request(searchText: searchText)
        self.interactor?.searchCharacters(request: request)
    }
}

// MARK: Display Logic

extension CharactersViewController: CharactersDisplayLogic {
    
    func displayCharacters(viewModel: Characters.GetCharacters.ViewModel) {
        LoadingView.dismiss()
        self.viewModel = viewModel
        tableView.reloadData()
    }
    
    func displaySearchedCharacters(viewModel: Characters.SearchCharacters.ViewModel) {
//        self.searchedViewModel = viewModel
        tableView.reloadData()
    }
    
    func displayError(_ error: Characters.Error) {
        LoadingView.dismiss()
    }
}

// MARK: TableView Data Source

extension CharactersViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.displayedCharacters.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let displayedCharacter = viewModel?.displayedCharacters[indexPath.row]
        cell.textLabel?.text = displayedCharacter?.name
        return cell
    }
    
    //MARK: Swipe Action
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var displayedCharacter = viewModel?.displayedCharacters[indexPath.row]
        let action = FavoriteContextualAction { (action, sourceView, completion) in
            self.saveCharacterOnFavorite(at: indexPath)
            displayedCharacter?.isFavorited = true
            completion(true)
            self.tableView.reloadData()
        }
        action.isFavorite = displayedCharacter?.isFavorited ?? false
        let swipeActionsConfiguration = UISwipeActionsConfiguration(actions: [action])
        return swipeActionsConfiguration
    }
}

// MARK: UISearchController Delegate

extension CharactersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        dispatchWorkItem.cancel()
        dispatchWorkItem = DispatchWorkItem(block: { [weak self] in
            guard let self = self else { return }
            self.searchCharacters()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: dispatchWorkItem)
    }
}
