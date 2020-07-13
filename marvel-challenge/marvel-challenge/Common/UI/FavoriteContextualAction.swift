//
//  File.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 12/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//

import UIKit

class FavoriteContextualAction: UIContextualAction {
    
    //MARK: Object Lifecycle
    
    var isFavorite: Bool = false {
        didSet {
            image = nil
            if isFavorite {
                image = UIImage(named: "star-filled")
            } else {
                image = UIImage(named: "star-empty")
            }
        }
    }
    
    //MARK: Object Lifecycle
    
    private override init() {}
    
    convenience init(handler: @escaping UIContextualAction.Handler) {
        self.init(style: .normal, title: nil, handler: handler)

        setup()
    }
    
    func changeColor() {
        backgroundColor = .yellow
    }
    //MARK: Private Functions
    
    private func setup() {
        isFavorite = false
    }
}
