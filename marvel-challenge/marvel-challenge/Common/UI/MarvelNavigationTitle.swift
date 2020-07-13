//
//  MarvelNavigationTitle.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 12/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//

import UIKit

class MarvelNavigationTitleView: UIView {
    
    //MARK: UI Elements
    let marvelLogoImage = UIImage(named: "MarvelLogo")
    lazy var imageView = UIImageView(image: marvelLogoImage)
    
    //MARK: Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    //MARK: Private Functions
    
    private func setupUI() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
