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
    var displayedCharacters: [Characters.DisplayedCharacter] = []
    var error: Characters.Error?
    
    // MARK: Variables
    
    var isSearching: Bool { !searchController.searchBar.text!.isEmpty }
    
    // MARK: UI Elements
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.isUserInteractionEnabled = false
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
        if !displayedCharacters.isEmpty {
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
        tableView.tableFooterView = UIView()
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
        tableView.backgroundView = nil
        let searchText = searchController.searchBar.text ?? ""
        interactor?.updateIsSearching(isSearching: isSearching)
        let request = Characters.SearchCharacters.Request(searchText: searchText)
        self.interactor?.searchCharacters(request: request)
    }
}

// MARK: Display Logic

extension CharactersViewController: CharactersDisplayLogic {
    
    func displayCharacters(viewModel: Characters.GetCharacters.ViewModel) {
        searchController.searchBar.isUserInteractionEnabled = true
        LoadingView.dismiss()
        displayedCharacters = viewModel.displayedCharacters
        tableView.reloadData()
    }
    
    func displayError(_ error: Characters.Error) {
        LoadingView.dismiss()
        self.error = error
        let alertView = AlertView()
        alertView.message = error.message
        alertView.delegate = self
        switch error {
        case .emptyList:
            alertView.buttonTitle = ""
        case .unexpectedError:
            alertView.buttonTitle = "OK"
        case .database:
            alertView.buttonTitle = "OK"
        case .notConnectedToInternet:
            alertView.buttonTitle = "Tentar Novamente"
        }
        tableView.backgroundView = alertView
    }
}

// MARK: TableView Data Source

extension CharactersViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedCharacters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let displayedCharacter = displayedCharacters[indexPath.row]
        cell.textLabel?.text = displayedCharacter.name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let displayedCharacter = displayedCharacters[indexPath.row]
        
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
        action.isFavorite = displayedCharacter.isFavorited
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToDetail()
    }
}

// MARK: UISearchController Delegate

extension CharactersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        interactor?.updateIsSearching(isSearching: isSearching)
        dispatchWorkItem.cancel()
        dispatchWorkItem = DispatchWorkItem(block: { [weak self] in
            guard let self = self else { return }
            self.searchCharacters()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: dispatchWorkItem)
    }
}

extension CharactersViewController: AlertViewDelegate {
    func alertView(_ alertView: AlertView, didTouchButton button: UIButton) {
        guard let error = error else { return }
        switch error {
        case .notConnectedToInternet:
            requestCharacters()
            alertView.removeFromSuperview()
        case .emptyList:
            break
        case .unexpectedError:
            alertView.removeFromSuperview()
        case .database:
            alertView.removeFromSuperview()
        }
        self.error = nil
    }
}
