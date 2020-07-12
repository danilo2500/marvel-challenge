//
//  CharactersViewController.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright (c) 2020 danilo. All rights reserved.

import UIKit

protocol CharactersDisplayLogic: AnyObject {
    func displayCharacters(viewModel: Characters.GetCharacters.ViewModel)
    func displayError(_ error: Characters.Error)
}

class CharactersViewController: UIViewController {
    
    var interactor: CharactersBusinessLogic?
    var router: (NSObjectProtocol & CharactersRoutingLogic & CharactersDataPassing)?
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestCharacters()
    }
    
    // MARK: Private Functions
    
    private func requestCharacters() {
        interactor?.requestCharacters()
    }
}

// MARK: Display Logic

extension CharactersViewController: CharactersDisplayLogic {
    
    func displayCharacters(viewModel: Characters.GetCharacters.ViewModel) {
        
    }
    
    func displayError(_ error: Characters.Error) {
        
    }
    
}
