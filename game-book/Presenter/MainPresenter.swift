//
//  MainController.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

//  Procotol who decides whose methods will be shown to the MainViewController
protocol MainPresentationLogic {
    func askForGames()
}

class MainPresenter {
    var viewController: MainDisplayLogic!
    
    func mapGames(_ games: [Game]) -> MainModels.GetGameList.ViewModel {
        
        let displayedGames = games.map { game -> DisplayedGame in
            //  Converting the array of platforms into a single string to show in the label
            let platformsArray = game.platforms
            let platformsJoined = platformsArray?.joined(separator: ", ")
            
            // Getting the video id only in the url to fill the paramter on YTPlayerView Request
            let videoURL = game.trailerURL!
            let index = videoURL.index(videoURL.startIndex, offsetBy: 32)
            let videoID = String(videoURL[index...])
            
            //  Mapping the object came from service response to a view model
            return DisplayedGame(id: game.id ?? 0,
                                 name: game.name ?? "",
                                 imageURL: game.imageURL ?? "",
                                 releaseDate: game.releaseDate ?? "",
                                 trailerURL: videoID,
                                 platforms: platformsJoined ?? "")
        }
        
        let viewModel = MainModels.GetGameList.ViewModel(displayedGames: displayedGames)
        return viewModel
    }
}

//  Implementation of MainPresentationLogic: Does a request to the services layer and map its result
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
