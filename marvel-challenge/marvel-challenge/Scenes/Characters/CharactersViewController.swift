//
//  CharactersViewController.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright (c) 2020 danilo. All rights reserved.

import UIKit

protocol CharactersDisplayLogic: AnyObject {
    func displaySomething(viewModel: Characters.Something.ViewModel)
}

class CharactersViewController: UIViewController, CharactersDisplayLogic {
    
    var interactor: CharactersBusinessLogic?
    var router: (NSObjectProtocol & CharactersRoutingLogic & CharactersDataPassing)?
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func requestCharacters()
    {
        let request = Characters.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Characters.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
}
