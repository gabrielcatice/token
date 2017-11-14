//
//  GameDetailPresenter.swift
//  game-book
//
//  Created by Gabriel Catice on 11/10/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

//  Procotol who decides whose methods will be shown to the UserViewController
protocol GameDetailPresentationLogic {
    func askForGame(request: GameDetailsModels.GetGameDetail.Request)
}

class GameDetailPresenter {
    var viewController: GameDetailDisplayLogic!
    
    func mapGame(_ game: Game) -> GameDetailsModels.GetGameDetail.ViewModel {
        //  Converting the array of platforms into a single string to show in the label
        let platformsArray = game.platforms
        let platformsJoined = platformsArray?.joined(separator: ", ")
        
        // Getting the video id only in the url to fill the paramter on YTPlayerView Request
        let videoURL = game.trailerURL!
        let index = videoURL.index(of: "=")!
        let videoID = String(videoURL[index...])
        
        let displayedGame = DisplayedGameDetail(id: game.id ?? 0, name: game.name ?? "", imageURL: game.imageURL ?? "", releaseDate: game.releaseDate ?? "", trailerURL: videoID, platforms: platformsJoined ?? "")
        let viewModel = GameDetailsModels.GetGameDetail.ViewModel(gameDetail: displayedGame)
        return viewModel
    }
}

//  Implementation of GameDetailPresentationLogic: Does a request to the services layer and map its result
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

