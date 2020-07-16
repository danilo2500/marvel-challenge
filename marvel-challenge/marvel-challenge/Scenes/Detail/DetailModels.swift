//
//  DetailModels.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 14/07/20.
//  Copyright (c) 2020 danilo. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Detail {
    
    // MARK: Use cases
    
    enum Character {
        struct Response {
            let character: CharacterModel
            let favoriteCharacter: FavoriteCharacterEntity?
        }
        struct ViewModel {
            let name: String
            let description: String
            let isFavorited: Bool
        }
    }
    
    enum GetImage {
        struct Response {
            let image: UIImage
        }
        struct ViewModel {
            let image: UIImage
        }
    }
    
    enum Error {
        case unexpectedError
        case database
        
        var message: String {
            switch self {
            case .unexpectedError:
                return ErrorConstants.unexpectedError
            case .database:
                return ErrorConstants.database
            }
        }
    }
}
