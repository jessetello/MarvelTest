//
//  CharacterCell.swift
//  MarvelTest
//
//  Created by Jesse Tello on 12/5/19.
//  Copyright © 2019 MarvelTest. All rights reserved.
//

import Foundation
import UIKit

class CharacterCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    var viewModel: CharacterCellViewModel? {
        didSet {
            characterImageView.loadImage(fromURL: viewModel?.imageURL)
            characterNameLabel.text = viewModel?.name
        }
    }
}

