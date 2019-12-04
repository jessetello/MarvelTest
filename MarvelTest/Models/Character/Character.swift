//
//  Character.swift
//  MarvelTest
//
//  Created by Jesse Tello on 12/3/19.
//  Copyright © 2019 MarvelTest. All rights reserved.
//

import Foundation

struct Character: Codable {
    let id: Int?
    let name: String?
    let thumbnail: Image?
    
    enum CodingKeys: String, CodingKey {
            case id
            case name
            case thumbnail
    }
}
