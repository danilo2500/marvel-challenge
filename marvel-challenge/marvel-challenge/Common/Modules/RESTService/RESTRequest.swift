//
//  RequestProtocol.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright © 2020 Danilo Henrique. All rights reserved.
//

import Foundation

protocol RESTRequest {
    var httpMethod: HTTPMethod { get }
    var baseURL: URL { get }
    var endpoint: String { get }
}
