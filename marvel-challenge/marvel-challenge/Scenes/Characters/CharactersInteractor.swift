//
//  CharactersInteractor.swift
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

protocol CharactersBusinessLogic {
    func requestCharacters()
    func searchCharacters(request: Characters.SearchCharacters.Request)
    func saveCharacterInFavorite(request: Characters.SaveInFavorite.Request)
}

protocol CharactersDataStore {
    
}

class CharactersInteractor: CharactersBusinessLogic, CharactersDataStore {
    
    var presenter: CharactersPresentationLogic?
    var worker: CharactersWorker? = CharactersWorker(manager: CharactersNetworkManager())
    
    var characterDataWrapper: CharacterDataWrapperModel?
    var searchedCharacters: [CharacterModel] = []
    
    // MARK: Business Logic
    
    func requestCharacters() {
        worker?.requestCharacters(completion: { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let characterDataWrapper):
                self.successRequestCharacters(characterDataWrapper: characterDataWrapper)
            case .failure:
                self.presenter?.presentError(.unexpectedError)
            }
        })
    }
    
    private func successRequestCharacters(characterDataWrapper: CharacterDataWrapperModel) {
        self.characterDataWrapper = characterDataWrapper
        guard let results = characterDataWrapper.data?.results, !results.isEmpty else {
            presenter?.presentError(.emptyList)
            return
        }
        let response = Characters.GetCharacters.Response(results: results)
        self.presenter?.presentCharacters(response: response)
    }
    
    func searchCharacters(request: Characters.SearchCharacters.Request) {
        guard let results = characterDataWrapper?.data?.results, !results.isEmpty else {
            presenter?.presentError(.emptyList)
            return
        }

        let options: String.CompareOptions = [.caseInsensitive, .diacriticInsensitive]
        searchedCharacters = results.filter { (character) -> Bool in
            return character.name?.range(of: request.searchText, options: options) != nil
        }
        
        let response = Characters.SearchCharacters.Response(results: searchedCharacters)
        presenter?.presentSearchCharacters(response: response)
    }
    
    func saveCharacterInFavorite(request: Characters.SaveInFavorite.Request) {
         
    }
}
