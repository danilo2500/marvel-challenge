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
        shared.addActivityView()
    }
    
    static func dismiss() {
        shared.removeFromSuperview()
    }
    
    func setup() {
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    //MARK: Private Functions
    
    private func addSelfOnWindow() {
        let window = UIApplication.shared.currentWindow
        window?.addSubview(self)
    }
    
    private func addActivityView() {
        let activity = NVActivityIndicatorView(frame: frame, type: .ballRotateChase, color: .black)
        activity.startAnimating()
        addSubview(activity)
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activity.heightAnchor.constraint(equalToConstant: 100).isActive = true
        activity.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
