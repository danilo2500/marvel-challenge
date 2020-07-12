//
//  FavoritesViewController.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright (c) 2020 danilo. All rights reserved.

import UIKit

protocol FavoritesDisplayLogic: AnyObject {
    func displaySomething(viewModel: Favorites.Something.ViewModel)
}

class FavoritesViewController: UIViewController, FavoritesDisplayLogic {
    
    var interactor: FavoritesBusinessLogic?
    var router: (NSObjectProtocol & FavoritesRoutingLogic & FavoritesDataPassing)?
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func requestFavorites()
    {
        let request = Favorites.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Favorites.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
}
