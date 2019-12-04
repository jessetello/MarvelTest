//
//  ComicService.swift
//  MarvelTest
//
//  Created by Jesse Tello on 11/30/19.
//  Copyright © 2019 MarvelTest. All rights reserved.
//

import Foundation

enum ComicService {
    case comic(id: Int)
    case characters(id: Int)
}

extension ComicService: Service {
    
    var baseURL: String {
        return "https://gateway.marvel.com"
    }
    
    var path: String {
        switch self {
        case .comic(id: let id):
            return "/v1/public/comics/\(id)"
        case .characters(id: let id):
            return "/v1/public/comics/\(id)/characters"
        }
    }
    
    var parameters: [String: Any]? {
        // APIKeys only hardcoded only for assignment
        let timestamp = "\(Date().timeIntervalSince1970)"
        let params: [String: Any] = ["apikey": "d81527b691c1618c13d9056fe3a1d9c4",
                                     "ts": timestamp,
                                     "hash": "\(timestamp)\("2e082337a00aed80b9ba0fca7df783680c5d35c0")\("d81527b691c1618c13d9056fe3a1d9c4")".md5()]
        
        //Handle case specific request parameters if ncessary
        switch self {
        case .comic(id: _):
             return params
        case .characters(id: _):
             return params
        }
    }
    
    var method: ServiceMethod {
        return .get
    }
}

enum MarvelError: Error {
    case decoding
}

