//
//  FavoritesPresenter.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright (c) 2020 danilo. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol FavoritesPresentationLogic {
    func presentSomething(response: Favorites.Something.Response)
}

class FavoritesPresenter: FavoritesPresentationLogic {
    
    weak var viewController: FavoritesDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Favorites.Something.Response) {
        let viewModel = Favorites.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}