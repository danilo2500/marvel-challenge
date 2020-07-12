//
//  RequestProtocol.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright © 2020 Danilo Henrique. All rights reserved.
//

import Foundation

protocol RESTRequest {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var httpMethod: HTTPMethod { get }
}
