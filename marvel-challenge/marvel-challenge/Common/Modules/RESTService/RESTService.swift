//
//  RESTService.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright © 2020 Danilo Henrique. All rights reserved.
//

import Foundation

class RESTService<T: RESTRequest>{
    func request<U: Decodable>(_ request: T, completion: @escaping (Result<U, Error>) -> Void ) {
        var url = request.baseURL
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                do {
                    let object = try JSONDecoder().decode(U.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            }
            if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}
