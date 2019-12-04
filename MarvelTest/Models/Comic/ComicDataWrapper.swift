//
//  MarvelAPIResponse.swift
//  MarvelTest
//
//  Created by Jesse Tello on 11/30/19.
//  Copyright © 2019 MarvelTest. All rights reserved.
//

import Foundation

struct ComicDataWrapper: Codable {
    
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: ComicDataContainer?
    let etag: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case status
        case copyright
        case attributionText
        case attributionHTML
        case data
        case etag
    }
}
