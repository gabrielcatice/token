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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    
    var presenter: MainPresentationLogic!
    var dataSet: [GameViewModel.DisplayedGame] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate = self
        //tableView.dataSource = self
        presenter.askForGames()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let presenter = MainPresenter()
        
        
        presenter.viewController = self
        self.presenter = presenter
    }
    
    @IBAction func userInfoPressed(_ sender: Any?) {
        performSegue(withIdentifier: "goToUser", sender: nil)
    }
}

extension MainViewController: MainDisplayLogic{
    func displayGames(viewModel: GameViewModel) {
        
        dataSet = viewModel.displayedGames
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
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
        activityIndicator.stopAnimating()
    }
    
    func displayError() {
        let alert = UIAlertController(title: "Erro", message: "Erro", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSet.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell", for: indexPath) as! GameTableViewCell
        let game = dataSet[indexPath.row]
        cell.gameName.text = game.name
        return cell
    }
}
