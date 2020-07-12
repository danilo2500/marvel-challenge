//
//  CharactersViewController.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright (c) 2020 danilo. All rights reserved.

import UIKit

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
    
    // MARK: UI Elements
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Pesquisar"
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
    }
    
    private func requestCharacters() {
        interactor?.requestCharacters()
    }
}

// MARK: Display Logic

extension CharactersViewController: CharactersDisplayLogic {
    
    func displayCharacters(viewModel: Characters.GetCharacters.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
    
    func displayError(_ error: Characters.Error) {
        
    }
    
}

// MARK: TableView Data Source

extension CharactersViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.displayedCharacters.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let displayedCharacter = viewModel?.displayedCharacters[indexPath.row]
        
        cell.textLabel?.text = displayedCharacter?.name
        
        return cell
    }
}

// MARK: UISearchController Delegate

extension CharactersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
