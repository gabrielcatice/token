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
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var presenter: MainPresentationLogic!
    var dataSet: [DisplayedGame] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(MainViewController.refresh(sender:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    @objc func refresh(sender: AnyObject) {
        self.getGames()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshControl.beginRefreshing()
        self.getGames()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let presenter = MainPresenter()
        
        
        presenter.viewController = self
        self.presenter = presenter
    }
    func getGames() {
        presenter.askForGames()
    }
    
    @IBAction func userInfoPressed(_ sender: Any?) {
        performSegue(withIdentifier: "goToUser", sender: nil)
    }
}

extension MainViewController: MainDisplayLogic{
    func displayGames(viewModel: MainModels.GetGameList.ViewModel) {
        
        dataSet = viewModel.displayedGames
        refreshControl.endRefreshing()
    }
    
    func displayError() {
        let alert = UIAlertController(title: "Sorry :(", message: "Could not load your game list", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
            self.refreshControl.endRefreshing()
        }
        let okAction = UIAlertAction(title: "Try Again", style: .cancel) { _ in
            self.refreshControl.beginRefreshing()
            self.getGames()
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell", for: indexPath) as! GameTableViewCell
        let game = dataSet[indexPath.row]
        let coverImage = URL(string: game.imageURL)!
        
        cell.gameImage.kf.indicatorType = .activity
        cell.gameImage.kf.setImage(with: coverImage, placeholder: #imageLiteral(resourceName: "MaxGames"))
        cell.gameName.text = game.name
        cell.gamePlatform.text = game.platforms
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = dataSet[indexPath.row]
        
        performSegue(withIdentifier: "goToDetail", sender: game)
    }
}
