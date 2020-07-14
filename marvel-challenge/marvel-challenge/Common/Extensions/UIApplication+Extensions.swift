//
//  UIAplicatoin+Extensions.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 13/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//

import UIKit

extension UIApplication {
    var currentWindow: UIWindow? {
        UIApplication.shared.windows.first(where: {$0.isKeyWindow})
    }
}
