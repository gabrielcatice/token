//
//  GameDetailViewModel.swift
//  game-book
//
//  Created by Gabriel Catice on 11/10/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

struct DisplayedGameDetail {
    let id: Int
    let name: String
    let imageURL: String
    let releaseDate: String
    let trailerURL: String
    let platforms: [String]
}

struct GameDetailsModels {
    struct GetGameDetail {
        struct Request {
            let id: Int
        }
        struct ViewModel {
            let gameDetail: DisplayedGameDetail
        }
    }
}
