//
//  CharacterDataContainer.swift
//  MarvelTest
//
//  Created by Jesse Tello on 12/3/19.
//  Copyright © 2019 MarvelTest. All rights reserved.
//

import Foundation

struct CharacterDataContainer: Codable {
    
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Character]?
    
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
}
