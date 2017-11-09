//
//  MainController.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

typealias GameViewModel = MainViewModels.GameViewModel

protocol MainPresentationLogic {
    func askForGames()
}

class MainPresenter {
    var viewController: MainDisplayLogic!
    
    func mapGames(_ games: [Game]) -> GameViewModel {
        let displayedGames = games.map { game in
            return GameViewModel.DisplayedGame(id: game.id ?? 0, name: game.name ?? "", imageURL: game.imageURL ?? "", releaseDate: game.releaseDate ?? "", trailerURL: game.trailerURL ?? "", platforms: game.platforms ?? [])
        }
        return GameViewModel(displayedGames: displayedGames)
    }
}

extension MainPresenter: MainPresentationLogic {
    func askForGames() {
        GameService.fetch { (result) in
            switch result {
            case .success(let games):
                self.viewController.displayGames(viewModel: self.mapGames(games))
            case .failure(let error):
                self.viewController.displayError()
            }
        }
    }
}
