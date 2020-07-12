//
//  NSErrors.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 12/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//

import Foundation

public enum RESTError: Swift.Error {
    ///Could not create valid URL
    case failedToCreateURL
}


// MARK: - Error Descriptions

extension RESTError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToCreateURL:
            return "Failed to create URL"
        }
    }
}
