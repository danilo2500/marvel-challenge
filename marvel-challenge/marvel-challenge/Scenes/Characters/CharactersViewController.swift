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
    
    var dispatchWorkItem = DispatchWorkItem {}
    var viewModel: Characters.GetCharacters.ViewModel?
    
    // MARK: UI Elements
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        return searchController
    }()
    
    // MARK: Object Life Cycle
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel != nil {
            interactor?.getUpdatedFavorites()
        }
    }
    
    // MARK: Private Functions
    
    private func setup() {
        title = "Hérois"
    }
    
    private func setupUI() {
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
    
    private func removeCharacterFromFavorite(at indexPath: IndexPath) {
        let request = Characters.RemoveFromFavorite.Request(indexPath: indexPath)
        interactor?.removeCharacterFromFavorite(request: request)
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
    
    func displayError(_ error: Characters.Error) {
        LoadingView.dismiss()
        showAlert(message: error.message)
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
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let displayedCharacter = viewModel?.displayedCharacters[indexPath.row]
        
        let action = FavoriteContextualAction { [weak self] (action, sourceView, completion) in
            guard let self = self else { return }
            let action = action as! FavoriteContextualAction
            if action.isFavorite {
                self.removeCharacterFromFavorite(at: indexPath)
                self.showAlert(message: "Héroi removido dos favoritos")
            } else {
                self.saveCharacterOnFavorite(at: indexPath)
                self.showAlert(message: "Héroi adicionado aos favoritos")
            }
            
            self.interactor?.getUpdatedFavorites()
        }
        action.isFavorite = displayedCharacter?.isFavorited ?? false
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToDetail()
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
