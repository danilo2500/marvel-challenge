//
//  UIViewController+Extensions.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 15/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

