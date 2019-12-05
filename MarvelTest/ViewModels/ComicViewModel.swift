//
//  ComicViewModel.swift
//  MarvelTest
//
//  Created by Jesse Tello on 12/1/19.
//  Copyright © 2019 MarvelTest. All rights reserved.
//

import Foundation

protocol ComicViewModelDelegate: class {
    func displayComic(imageURL: URL?,
                      title: String,
                      description: String)
    func displayCharacters(title: String)
    func loadingComplete()
}

class ComicViewModel {

    private let provider = ServiceProvider<ComicService>()
    private var comic: Comic?
    private var characters: [Character?] = []
    weak var comicViewModelDelegate: ComicViewModelDelegate?
    
    var characterCount: Int {
        return characters.count
    }
    
    func loadComic(id: Int) {
        requestComic(id: id)
        requestCharacters(id: id)
        provider.dispatchGroup.notify(queue: .main) {
            self.comicViewModelDelegate?.loadingComplete()
        }
    }
    
    func characterViewModel(index: Int) -> CharacterCellViewModel? {
         guard let character = self.characters[index] else { return nil }
         let cellViewModel = CharacterCellViewModel(character: character)
         return cellViewModel
    }
    
    private func requestComic(id: Int) {
        provider.load(service: .comic(id: id),
                      decodeType: ComicDataWrapper.self) { [weak self] result in
                        switch result {
                        case .success(let wrapper):
                            guard let dataContainer = wrapper.data,
                                let comic = dataContainer.results?.first else {
                                    return
                            }
                            self?.loadComicInfo(comic: comic)
                            break
                        case .failure( _):
                            //Display Error
                            break
                        case .empty:
                            break
                        }
        }
    }
    
    private func loadComicInfo(comic: Comic) {
        comicViewModelDelegate?.displayComic(imageURL: comic.thumbnail?.url,
                                             title: comic.title ?? "Missing Title",
                                             description: comic.description ?? "Missing Description")
    }
    
    private func requestCharacters(id: Int) {
        provider.load(service: .characters(id: id),
                      decodeType: CharacterDataWrapper.self) { [weak self] result in
                        switch result {
                        case .success(let wrapper):
                            guard let dataContainer = wrapper.data,
                                let characters = dataContainer.results else {
                                    return
                            }
                            self?.characters = characters
                            let title = (self?.characters.count ?? 0) > 0 ? "Characters" : "No Characters"
                            self?.comicViewModelDelegate?.displayCharacters(title: title)
                            break
                        case .failure( _):
                            //Display Error
                            break
                        case .empty:
                            break
                        }
        }
    }
}

