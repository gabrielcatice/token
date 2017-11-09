//
//  UserViewController.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import UIKit

protocol UserDisplayLogic {
    func displayUser(viewModel: UserViewModel)
    func displayError()
}

class UserViewController: UIViewController {
    
    var presenter: UserPresentationLogic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.askForUser()
    }
    
}

extension UserViewController: UserDisplayLogic {
    func displayUser(viewModel: UserViewModel) {
        // Exibir na tela
        print("you're here")
        print(viewModel.name)
    }
    
    func displayError() {
        let alert = UIAlertController(title: "Erro", message: "Erro", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
    }
}
