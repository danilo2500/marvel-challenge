//
//  DetailPresenter.swift
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

protocol DetailPresentationLogic {
    func presentCharacter(response: Detail.Character.Response)
    func presentImage(response: Detail.GetImage.Response)
    func presentDatabaseSuccess()
    func presentError(_ error: Detail.Error)
}

class DetailPresenter: DetailPresentationLogic {
    
    weak var viewController: DetailDisplayLogic?
    
    // MARK: Presentation Logic
    
    func presentCharacter(response: Detail.Character.Response) {
        let name = response.character.name ?? "-"
        let isFavorited = response.favoriteCharacter != nil
        let description = response.character.description ?? "-"
        let viewModel = Detail.Character.ViewModel(name: name, description: description, isFavorited: isFavorited)
        viewController?.displayCharacter(viewModel: viewModel)
    }
    
    func presentImage(response: Detail.GetImage.Response) {
        let viewModel = Detail.GetImage.ViewModel(image: response.image)
        viewController?.displayImage(viewModel: viewModel)
    }
    
    func presentDatabaseSuccess() {
        viewController?.displayDatabaseSuccess()
    }
    
    func presentError(_ error: Detail.Error) {
        viewController?.displayError(error)
    }
}
