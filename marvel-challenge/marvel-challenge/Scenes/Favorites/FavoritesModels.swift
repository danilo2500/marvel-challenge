//
//  FavoritesModels.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright (c) 2020 danilo. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

enum Favorites {
    
    // MARK: Use cases
    
    enum GetFavorites {
        struct Response {
            let favorites: [FavoriteCharacterEntity]
        }
        struct ViewModel {
            let names: [String]
        }
    }
    
    enum RemoveFromDatabase {
        struct Request {
            let indexPath: IndexPath
        }
        struct Response {
            let indexPath: IndexPath
        }
        struct ViewModel {
            let indexPath: IndexPath
        }
    }
    
    enum Error {
        case database
        case emptyList
        
        var message: String {
            switch self {
            case .database:
                return ErrorConstants.database
            case .emptyList:
                return "Não há nenhum héroi marcado como favorito"
            }
        }
    }
}
