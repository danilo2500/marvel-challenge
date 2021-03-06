//
//  FavoritesRouter.swift
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

@objc protocol FavoritesRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol FavoritesDataPassing {
    var dataStore: FavoritesDataStore? { get }
}

class FavoritesRouter: NSObject, FavoritesRoutingLogic, FavoritesDataPassing {
    
    weak var viewController: FavoritesViewController?
    var dataStore: FavoritesDataStore?
    
    // MARK: Routing
    
}
