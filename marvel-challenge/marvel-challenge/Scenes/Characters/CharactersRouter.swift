//
//  CharactersRouter.swift
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

@objc protocol CharactersRoutingLogic {
    func routeToDetail()
}

protocol CharactersDataPassing {
    var dataStore: CharactersDataStore? { get }
}

class CharactersRouter: NSObject, CharactersRoutingLogic, CharactersDataPassing {
    
    weak var viewController: CharactersViewController?
    var dataStore: CharactersDataStore?
    
    // MARK: Routing
    
    func routeToDetail() {
        let destinationVC = DetailFactory.makeController()
        guard var destinationDS = destinationVC.router?.dataStore else { return }
        guard let indexPath = viewController?.tableView.indexPathForSelectedRow else { return }
        destinationDS.character = dataStore?.charactersBeingDisplayed[indexPath.row]
        
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
