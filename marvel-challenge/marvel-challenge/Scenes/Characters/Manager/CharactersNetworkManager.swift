//
//  QuestionAPIManager.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 01/02/20.
//  Copyright © 2020 Danilo Henrique. All rights reserved.
//

import Foundation

class CharactersNetworkManager: CharactersWorkerManager {
    
    func getCharacters(completion: @escaping (Result<CharacterDataWrapperModel, Error>) -> Void) {
        let restService = RESTService<CharactersAPI>()
        
        restService.request(.getCharacters) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
