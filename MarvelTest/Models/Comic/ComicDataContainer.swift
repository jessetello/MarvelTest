//
//  MarvelAPIData.swift
//  MarvelTest
//
//  Created by Jesse Tello on 11/30/19.
//  Copyright © 2019 MarvelTest. All rights reserved.
//

import Foundation

struct ComicDataContainer: Codable {
    
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Comic]?
    
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
}
