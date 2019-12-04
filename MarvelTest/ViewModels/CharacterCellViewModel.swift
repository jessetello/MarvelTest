//
//  CharacterCellViewModel.swift
//  MarvelTest
//
//  Created by Jesse Tello on 12/3/19.
//  Copyright © 2019 MarvelTest. All rights reserved.
//

import Foundation

struct CharacterCellViewModel {
    
    let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    var name: String {
        return character.name ?? ""
    }

    var imageURL: URL? {
        return character.thumbnail?.url
    }
}
