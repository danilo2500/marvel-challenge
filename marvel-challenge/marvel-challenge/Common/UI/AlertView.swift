//
//  AlertView.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 15/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//

import UIKit

protocol AlertViewDelegate: AnyObject {
    func alertView(_ alertView: AlertView, didTouchButton button: UIButton)
}

class AlertView: UIView {
    
    weak var delegate: AlertViewDelegate?
    
    //MARK: UI Variables
    
    lazy private var imageView: UIImageView = {
        let image = UIImage(named: "marvel-error")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    lazy private var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy private var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTouchButton), for: .touchUpInside)
        return button
    }()
    
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, messageLabel, button])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    //MARK: Variables
    
    var message: String {
        get {
            messageLabel.text ?? ""
        }
        set {
            messageLabel.text = newValue
        }
    }
    
    var buttonTitle: String {
        get {
            button.titleLabel?.text ?? ""
        }
        set {
            button.setTitle(newValue, for: .normal)
        }
    }
    
    //MARK: Object Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: Private Functions
    
    private func setup() {
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(lessThanOrEqualTo: topAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 20).isActive = true
    }
    
    @objc private func didTouchButton() {
        delegate?.alertView(self, didTouchButton: button)
    }
}
