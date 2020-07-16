//
//  QuizAPI.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 01/02/20.
//  Copyright © 2020 Danilo Henrique. All rights reserved.
//

import Foundation

enum CharactersAPI {
    case getCharacters
}

extension CharactersAPI: RESTRequest {
    var baseURL: String {
        return "https://gateway.marvel.com"
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/v1/public/characters"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        let timestamp = Timestamp.generateTimestamp()
        let timestampQueryItem = URLQueryItem(name: "ts", value: timestamp)
        
        let publicKey = "2bbd083d81b21292430be31638176b3d"
        let apiKeyQueryItem = URLQueryItem(name: "apikey", value: publicKey)
        
        let privateKey = "6a90c61e7c923bafbbdd995e6d567a8c2a74923a"
        let hashString = MD5.generateMD5Hash(from: timestamp + privateKey + publicKey)
        let hashQueryItem = URLQueryItem(name: "hash", value: hashString)
        
        return [timestampQueryItem, apiKeyQueryItem, hashQueryItem]
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getCharacters:
            return .get
        }
    }
}
