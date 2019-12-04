//
//  Comic.swift
//  MarvelTest
//
//  Created by Jesse Tello on 11/30/19.
//  Copyright © 2019 MarvelTest. All rights reserved.
//

import Foundation

struct Comic: Codable {
    
    let id: Int?
    let digitalId: Int?
    let title: String?
    let description: String?
    let thumbnail: Image?
    let images: [Image]?
    let characters: Characters?
    
    enum CodingKeys: String, CodingKey {
         case id
         case digitalId
         case title
         case description
         case thumbnail
         case images
         case characters
     }
}

struct Image: Codable {
    
    let url: URL

    enum ImageKeys: String, CodingKey {
        case fileExtention = "extension"
        case path
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageKeys.self)

          let path = try container.decode(String.self, forKey: .path)
          let fileExtension = try container.decode(String.self, forKey: .fileExtention)

          guard let url = URL(string: "\(path)/detail.\(fileExtension)") else { throw MarvelError.decoding }

          self.url = url
      }
}
