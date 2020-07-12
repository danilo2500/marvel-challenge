//
//  Timestamp.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 12/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//

import Foundation
import CryptoKit

class MD5 {
    static func generateMD5Hash(from string: String) -> String? {
        guard let data = string.data(using: .utf8) else { return nil }
        let md5 = Insecure.MD5.hash(data: data)
        let string = md5.map({String(format: "%02hhx", $0)}).joined()
        return string
    }
}
