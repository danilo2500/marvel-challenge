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
        navigationController.tabBarItem.image = UIImage(named: "avengers-icon")
        return navigationController
    }()
    
    let favoritesNavigationController: UINavigationController = {
        let viewController = FavoritesFactory.makeController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.image = UIImage(named: "star-empty")
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
        tabBar.tintColor = .red
        viewControllers = [charactersNavigationController, favoritesNavigationController]
    }
    
}
