//
//  RESTService.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 11/07/20.
//  Copyright © 2020 Danilo Henrique. All rights reserved.
//

import Foundation

class RESTService<T: RESTRequest>{
    func request<U: Decodable>(_ request: T, completion: @escaping (Result<U, Error>) -> Void) {
        guard let url = createURL(with: request) else {
            completion(.failure(RESTError.failedToCreateURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                do {
                    let object = try JSONDecoder().decode(U.self, from: data)
                    completion(.success(object))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            } else {
                print(error.debugDescription)
                completion(.failure(error ?? NSError()))
            }
        }.resume()
    }

    private func createURL(with request: T) -> URL? {
        var urlComponents = URLComponents(string: request.baseURL)
        urlComponents?.path = request.path
        urlComponents?.queryItems = request.queryItems
        
        return urlComponents?.url
    }
}
