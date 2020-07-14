//
//  CharactersModels.swift
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

enum Characters {
    
    // MARK: Use cases
    
    enum GetCharacters {
        struct Response {
            let results: [CharacterModel]
        }
        struct ViewModel {
            let displayedCharacters: [DisplayedCharacter]
        }
    }
    
    enum SearchCharacters {
        struct Request {
            let searchText: String
        }
        struct Response {
            let results: [CharacterModel]
        }
        struct ViewModel {
            let displayedCharacters: [DisplayedCharacter]
        }
    }
    
    // MARK: Use cases
    
    enum SaveInFavorite {
        struct Request {
            let indexPath: IndexPath
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
    
    struct DisplayedCharacter {
        let name: String
        var isFavorited: Bool
    }
    
    enum Error {
        case emptyList
        case unexpectedError
    }
}
