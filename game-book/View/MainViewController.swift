//
//  MainViewController.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import UIKit
import Kingfisher

protocol MainDisplayLogic {
    func displayGames(viewModel: MainModels.GetGameList.ViewModel)
    func displayError()
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var presenter: MainPresentationLogic!
    var dataSet: [DisplayedGame] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    func displayGames(viewModel: MainModels.GetGameList.ViewModel) {
        
        dataSet = viewModel.displayedGames
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        activityIndicator.stopAnimating()
    }
    
    func displayError() {
        let alert = UIAlertController(title: "Erro", message: "Erro", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
    }
}
extension MainViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let game = sender as! DisplayedGame
            (segue.destination as! GameDetailViewController).game = game
        }
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSet.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell") as! GameTableViewCell
        let game = dataSet[indexPath.row]
        let platformsArray = game.platforms
        let platformsJoined = platformsArray.joined(separator: ", ")
        
        //let coverImage = URL(string: game.imageURL)
        
        //cell.gameImage.kf.setImage(with: coverImage)
        cell.gameName.text = game.name
        cell.gamePlatform.text = platformsJoined
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = dataSet[indexPath.row]
        performSegue(withIdentifier: "goToDetail", sender: game)
    }
}
