//
//  FavoritesViewController.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright (c) 2020 danilo. All rights reserved.

import UIKit

protocol FavoritesDisplayLogic: AnyObject {
    func displayFavorites(viewModel: Favorites.GetFavorites.ViewModel)
    func displayRemoveFromDatabase(viewModel: Favorites.RemoveFromDatabase.ViewModel)
    func displayError(_ error: Favorites.Error)
}

class FavoritesViewController: UITableViewController {
    
    var interactor: FavoritesBusinessLogic?
    var router: (NSObjectProtocol & FavoritesRoutingLogic & FavoritesDataPassing)?
    
    // MARK: Constants
    
    let cellReuseIdentifier = String(describing: UITableViewCell.self)
    
    // MARK: Variables
    var error: Favorites.Error?
    var names: [String] = []

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
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestFavorites()
    }
    
    // MARK: Private Functions
    
    private func setup() {
        title = "Favoritos"
    }
    
    private func requestFavorites() {
        tableView.backgroundView = nil
        interactor?.requestFavorites()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.tableFooterView = UIView()
    }
}

// MARK: Display Logic

extension FavoritesViewController: FavoritesDisplayLogic {
    
    func displayFavorites(viewModel: Favorites.GetFavorites.ViewModel) {
        self.names = viewModel.names
        tableView.reloadData()
    }
    
    func displayRemoveFromDatabase(viewModel: Favorites.RemoveFromDatabase.ViewModel) {
        names.remove(at: viewModel.indexPath.row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [viewModel.indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    func displayError(_ error: Favorites.Error) {
        self.error = error
        
        let alertView = AlertView()
        alertView.message = error.message
        alertView.delegate = self
        switch error {
        case .emptyList:
            alertView.buttonTitle = ""
        case .database:
            alertView.buttonTitle = "OK"
        }
        tableView.backgroundView = alertView
    }
}

// MARK: TableView Data Source

extension FavoritesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.imageView?.image = UIImage(named: "star-filled")
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let request = Favorites.RemoveFromDatabase.Request(indexPath: indexPath)
        interactor?.removeFromDatabase(request: request)
    }
}

extension FavoritesViewController: AlertViewDelegate {
    func alertView(_ alertView: AlertView, didTouchButton button: UIButton) {
        guard let error = error else { return }
        switch error {
        case .emptyList:
            break
        case .database:
            alertView.removeFromSuperview()
        }
        self.error = nil
    }
}
