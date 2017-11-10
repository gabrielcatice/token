//
//  MainController.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

protocol MainPresentationLogic {
    func askForGames()
}

class MainPresenter {
    var viewController: MainDisplayLogic!
    
    func mapGames(_ games: [Game]) -> MainModels.GetGameList.ViewModel {
        
        let displayedGames = games.map { game in
            return DisplayedGame(id: game.id ?? 0,
                                 name: game.name ?? "",
                                 imageURL: game.imageURL ?? "",
                                 platforms: game.platforms ?? [])
        }
        let viewModel = MainModels.GetGameList.ViewModel(displayedGames: displayedGames)
        return viewModel
    }
}

extension MainPresenter: MainPresentationLogic {
    func askForGames() {
        GameService.fetch { (result) in
            
            switch result {
            case .success(let games):
                
                self.viewController.displayGames(viewModel: self.mapGames(games))
            case .failure( _):
                self.viewController.displayError()
            }
        }
    }
}
