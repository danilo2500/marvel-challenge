//
//  Timestamp.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 12/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//

import Foundation

class Timestamp {
    static func generateTimestamp() -> String {
        let date = Date()
        let timeInterval = date.timeIntervalSince1970
        return String(timeInterval)
    }
}
