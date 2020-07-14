//
//  MainTabBar.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    let charactersNavigationController: UINavigationController = {
        let viewController = CharactersFactory.makeController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.image = UIImage.init(named: "avengers-icon")
        return navigationController
    }()
    
    let favoritesNavigationController: UINavigationController = {
        let viewController = FavoritesFactory.makeController()
        let navigationController = UINavigationController(rootViewController: viewController)
//        navigationController.tabBarItem.image = UIImage.init(systemName: "avengers-icon")
        return navigationController
    }()
    
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
        viewControllers = [charactersNavigationController, favoritesNavigationController]
    }
    
}
