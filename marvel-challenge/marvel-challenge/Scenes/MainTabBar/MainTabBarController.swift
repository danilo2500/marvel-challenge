//
//  MainTabBar.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //MARK: Object Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: Private Functions
    
    private func setup() {
        //Characters
        let charactersViewController = CharactersFactory.makeController()
        let charactersNavigationController = UINavigationController(rootViewController: charactersViewController)
        
        //Favorites
        let favoritesViewController = FavoritesFactory.makeController()
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        
        viewControllers = [charactersNavigationController, favoritesNavigationController]
    }
    
}
