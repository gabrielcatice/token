//
//  MainViewController.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import UIKit

protocol MainDisplayLogic {
    func displayGames(viewModel: GameViewModel)
    func displayError()
}

class MainViewController: UIViewController {
    
    var presenter: MainPresentationLogic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.askForGames()
    }
    
}

extension MainViewController: MainDisplayLogic {
    func displayGames(viewModel: GameViewModel) {
        
        var aux: Int = 0
        repeat {
            print(viewModel.displayedGames[aux].id)
            print(viewModel.displayedGames[aux].name)
            print(viewModel.displayedGames[aux].imageURL)
            print(viewModel.displayedGames[aux].releaseDate)
            print(viewModel.displayedGames[aux].trailerURL)
            print(viewModel.displayedGames[aux].platforms)
            aux = aux + 1
        } while aux < 14
    }
    
    func displayError() {
        let alert = UIAlertController(title: "Erro", message: "Erro", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
    }
}

