//
//  MainViewModels.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

struct DisplayedGame {
    let id: Int
    let name: String
    let imageURL: String
    let releaseDate: String
    let trailerURL: String
    let platforms: String
}

struct MainModels {
    struct GetGameList {
        struct ViewModel {
            let displayedGames: [DisplayedGame]
        }
        
    }
}
