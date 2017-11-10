//
//  GameDetailViewController.swift
//  game-book
//
//  Created by Gabriel Catice on 11/10/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import UIKit

protocol GameDetailDisplayLogic {
    func displayGame(viewModel: GameDetailsModels.GetGameDetail.ViewModel)
    func displayError()
}

class GameDetailViewController: UIViewController {

    var game: DisplayedGame!
    var presenter: GameDetailPresentationLogic!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let request = GameDetailsModels.GetGameDetail.Request(id: game.id)
        presenter.askForGame(request: request)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let presenter = GameDetailPresenter()
        presenter.viewController = self
        self.presenter = presenter
    }
}

extension GameDetailViewController: GameDetailDisplayLogic {
    func displayGame(viewModel: GameDetailsModels.GetGameDetail.ViewModel) {
        
    }
    func displayError() {

    }
}
