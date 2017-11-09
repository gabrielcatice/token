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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var presenter: UserPresentationLogic!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.askForUser()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let presenter = UserPresenter()
        presenter.viewController = self
        self.presenter = presenter
    }
}

extension UserViewController: UserDisplayLogic {
    func displayUser(viewModel: UserViewModel) {
        // Exibir na tela
        activityIndicator.startAnimating()
        
        print(viewModel.name)
        print(viewModel.lastname)
        print(viewModel.avatar)
        print(viewModel.email)
        print(viewModel.birthday)
        print(viewModel.address)
        print(viewModel.city)
        print(viewModel.country)
        
        activityIndicator.stopAnimating()
    }
    
    func displayError() {
        let alert = UIAlertController(title: "Erro", message: "Erro", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
    }
}
