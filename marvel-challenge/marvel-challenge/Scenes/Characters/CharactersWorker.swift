//
//  CharactersWorker.swift
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

protocol CharactersWorkerManager {
    func getCharacters(completion: @escaping (Result<CharacterDataWrapperModel, Error>) -> Void)
}

class CharactersWorker {
    
    let manager: CharactersWorkerManager
    
    init(manager: CharactersWorkerManager) {
        self.manager = manager
        
    }
    
    func getCharacters(completion: @escaping (Result<CharacterDataWrapperModel, Error>) -> Void ) {
        manager.getCharacters(completion: completion)
    }
    
    func saveCharacterOnFavorite(name: String, id: Int, completion: (Error?) -> Void) {
        let object = FavoriteCharacterEntity()
        object.name = name
        object.id = Int32(id)
        
        CoreDataManager().save(object: object, completion: completion)
    }
    
    func removeCharacterFromFavorite(id: Int, completion: (Error?) -> Void) {
        let entityName = String(describing: FavoriteCharacterEntity.self)
        CoreDataManager().get(entityName: entityName, withId: id) { (result) in
            switch result {
            case .success(let favorites):
                for favorite in favorites {
                    CoreDataManager().delete(object: favorite, completion: nil)
                }
                completion(nil)
            case .failure:
                completion(NSError())
            }
        }
    }
    
    func getFavoriteCharacters(completion: (Result<[FavoriteCharacterEntity], Error>) -> Void) {
        let entityName = String(describing: FavoriteCharacterEntity.self)
        CoreDataManager().getAll(entityName: entityName, completion: completion)
    }
    
}
