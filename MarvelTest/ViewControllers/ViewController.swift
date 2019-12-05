//
//  ViewController.swift
//  MarvelTest
//
//  Created by Jesse Tello on 11/30/19.
//  Copyright © 2019 MarvelTest. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var comicMainImageView: UIImageView!
    @IBOutlet weak var comicTitleLabel: UILabel!
    @IBOutlet weak var comicDescriptionLabel: UILabel!
    @IBOutlet weak var charactersLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
        }
    }
    
    var comicId = 1332
    var viewModel = ComicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
        viewModel.loadComic(id: comicId)
    }
    
    private func controllerSetup() {
        flowLayoutSetup()
        collectionView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCell")
        viewModel.comicViewModelDelegate = self
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    private func flowLayoutSetup() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: width/3, height: width/3)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collectionView.collectionViewLayout = layout
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characterCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        let cellModel = viewModel.characterViewModel(index: indexPath.row)
        cell.viewModel = cellModel
        return cell
    }
}

extension ViewController: ComicViewModelDelegate {
   
    func loadingComplete() {
        activityIndicator.stopAnimating()
    }
    
    func displayCharacters(title: String) {
        DispatchQueue.main.async {
            self.charactersLabel.text = title
            self.collectionView.reloadData()
        }
    }

    func displayComic(imageURL: URL?,
                      title: String,
                      description: String) {
        if let url = imageURL {
            comicMainImageView.loadImage(fromURL: url)
        }
        comicTitleLabel.text = title
        comicDescriptionLabel.text = description
    }
}

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

