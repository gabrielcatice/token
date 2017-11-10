//
//  GameDetailPresenter.swift
//  game-book
//
//  Created by Gabriel Catice on 11/10/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

protocol GameDetailPresentationLogic {
    func askForGame(request: GameDetailsModels.GetGameDetail.Request)
}

class GameDetailPresenter {
    var viewController: GameDetailDisplayLogic!
    
    func mapGame(_ game: Game) -> GameDetailsModels.GetGameDetail.ViewModel {
        
        let displayedGame = DisplayedGameDetail(id: game.id ?? 0, name: game.name ?? "", imageURL: game.imageURL ?? "", releaseDate: game.releaseDate ?? "", trailerURL: game.trailerURL ?? "", platforms: game.platforms ?? [])
        let viewModel = GameDetailsModels.GetGameDetail.ViewModel(gameDetail: displayedGame)
        return viewModel
    }
}

extension GameDetailPresenter: GameDetailPresentationLogic {
    func askForGame(request: GameDetailsModels.GetGameDetail.Request) {
        GameService.getItem(with: request.id) { (result) in
            switch result {
            case .success(let game):
                self.viewController.displayGame(viewModel: self.mapGame(game))
            case .failure( _):
                self.viewController.displayError()
            }
        }
    }
}

