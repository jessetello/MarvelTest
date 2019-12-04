//
//  ServiceProvider.swift
//  MarvelTest
//
//  Created by Jesse Tello on 11/30/19.
//  Copyright © 2019 MarvelTest. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
    case empty
}

class ServiceProvider<T: Service> {
    
    let urlSession = URLSession.shared

    init() { }
    
    func load(service: T, completion: @escaping (Result<Data>) -> Void) {
        call(service.urlRequest, completion: completion)
    }
    
    func load<U>(service: T,
                 decodeType: U.Type,
                 completion: @escaping (Result<U>) -> Void) where U: Decodable {
        
        call(service.urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let resp = try decoder.decode(decodeType, from: data)
                    completion(.success(resp))
                }
                catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            case .empty:
                completion(.empty)
            }
        }
    }
}

extension ServiceProvider {
    private func call(_ request: URLRequest,
                      deliverQueue: DispatchQueue = DispatchQueue.main,
                      completion: @escaping (Result<Data>) -> Void) {
        urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                deliverQueue.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                deliverQueue.async {
                    completion(.success(data))
                }
            } else {
                deliverQueue.async {
                    completion(.empty)
                }
            }
        }.resume()
    }
}
