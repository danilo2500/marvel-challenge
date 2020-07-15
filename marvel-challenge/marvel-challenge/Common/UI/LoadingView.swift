//
//  LoadingView.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 13/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoadingView: UIView {
    
    static private let shared = LoadingView()
    
    //MARK: Object Life Cycle
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: Public Functions
    
    static func show() {
        shared.addSelfOnWindow()
    }
    
    static func dismiss() {
        UIView.animate(withDuration: 0.5, animations: {
            shared.alpha = 0
        }) { (_) in
            shared.removeFromSuperview()
        }
    }
    
    //MARK: Private Functions
    
    func setup() {
        backgroundColor = UIColor.black.withAlphaComponent(0)
        addActivityView()
    }
    
    private func addSelfOnWindow() {
        let window = UIApplication.shared.currentWindow
        window?.addSubview(self)
        alpha = 1
        UIView.animate(withDuration: 0.5) {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        }
    }
    
    private func addActivityView() {
        let activity = NVActivityIndicatorView(frame: frame, type: .ballRotateChase, color: .black)
        activity.startAnimating()
        addSubview(activity)
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activity.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activity.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
