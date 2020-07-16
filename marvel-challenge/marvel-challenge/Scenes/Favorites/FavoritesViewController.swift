//
//  FavoritesViewController.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright (c) 2020 danilo. All rights reserved.

import UIKit

protocol FavoritesDisplayLogic: AnyObject {
    func displayFavorites(viewModel: Favorites.GetFavorites.ViewModel)
    func displayError(_ error: Favorites.Error)
}

class FavoritesViewController: UITableViewController {
    
    var interactor: FavoritesBusinessLogic?
    var router: (NSObjectProtocol & FavoritesRoutingLogic & FavoritesDataPassing)?
    
    // MARK: Constants
    
    let cellReuseIdentifier = String(describing: UITableViewCell.self)
    
    // MARK: Variables
    
    var viewModel: Favorites.GetFavorites.ViewModel?

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
        interactor?.requestFavorites()
    }
    
    // MARK: Private Functions
    
    private func setup() {
        title = "Favoritos"
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
}

// MARK: Display Logic

extension FavoritesViewController: FavoritesDisplayLogic {
    func displayFavorites(viewModel: Favorites.GetFavorites.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
    
    func displayError(_ error: Favorites.Error) {
        showAlert(message: error.message)
    }
}

// MARK: TableView Data Source

extension FavoritesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.names.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.imageView?.image = UIImage(named: "star-filled")
        cell.textLabel?.text = viewModel?.names[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel?.names.remove(at: indexPath.row)
        interactor?.removeFavoriteFromDatabase(at: indexPath)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}
