//
//  CharacterList.swift
//  MarvelTest
//
//  Created by Jesse Tello on 12/1/19.
//  Copyright © 2019 MarvelTest. All rights reserved.
//

import Foundation

struct Characters: Codable {
    
     let available: Int?
     let collectionURI: String?
     let items: [CharacterSummary]?
    
     enum CodingKeys: String, CodingKey {
         case available
         case collectionURI
         case items
     }
}

struct CharacterSummary: Codable {
    
    let resourceURI: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
            case resourceURI
            case name
    }
}
