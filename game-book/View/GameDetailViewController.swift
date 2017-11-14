//
//  GameDetailViewController.swift
//  game-book
//
//  Created by Gabriel Catice on 11/10/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import UIKit
import Kingfisher
import youtube_ios_player_helper

//  This procotol receive data from the presenter
protocol GameDetailDisplayLogic {
    func displayGame(viewModel: GameDetailsModels.GetGameDetail.ViewModel)
    func displayError()
}

class GameDetailViewController: UIViewController {
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gamePlatforms: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var videoActivtyLoading: UIActivityIndicatorView!
    @IBOutlet weak var thumbContainerView: UIView!
    @IBAction func playPressed(_ sender: Any) {
        thumbContainerView.isHidden = true
        playerView.playVideo()
    }
    
    var game: DisplayedGame!
    var presenter: GameDetailPresentationLogic!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let request = GameDetailsModels.GetGameDetail.Request(id: game.id)
        presenter.askForGame(request: request) //  Call the method to request data on presenter
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        //  Setting up the presenter
        let presenter = GameDetailPresenter()
        presenter.viewController = self
        self.presenter = presenter
    }
}

extension GameDetailViewController: GameDetailDisplayLogic {
    
    func displayGame(viewModel: GameDetailsModels.GetGameDetail.ViewModel) {
        
       let gameImage = URL(string: game.imageURL)
        
        // Verifying if data is null to hide objects from the screen
        if game.name == "" {
            gameTitle.isHidden = true
        } else {
            gameTitle.text = game.name
        }
        if game.platforms == "" {
            gamePlatforms.isHidden = true
        } else {
            gamePlatforms.text = game.platforms
        }
        if game.releaseDate == "" {
            releaseDate.isHidden = true
        } else {
           releaseDate.text = game.releaseDate
        }
        
        if self.playerView.load(withVideoId: game.trailerURL) {
            self.videoActivtyLoading.startAnimating()
        }
        
        coverImage.kf.indicatorType = .activity
        coverImage.kf.setImage(with: gameImage, placeholder: #imageLiteral(resourceName: "MaxGames"))
    }
    
    func displayError() {
        //  Case failure: error treatments
        let alert = UIAlertController(title: "Sorry :(", message: "Could not load your game info", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Try Again", style: .cancel) { _ in
            let request = GameDetailsModels.GetGameDetail.Request(id: self.game.id)
            self.presenter.askForGame(request: request)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}


