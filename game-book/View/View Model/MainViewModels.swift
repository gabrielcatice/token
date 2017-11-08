//
//  MainViewModels.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

struct MainViewModels {
    struct GameViewModel {
        struct DisplayedGame {
            let name: String
            let date: String
        }
        
        
        let displayedGames: [DisplayedGame]
    }
}
