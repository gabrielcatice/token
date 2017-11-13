//
//  UserViewController.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import UIKit
import Kingfisher


protocol UserDisplayLogic {
    func displayUser(viewModel: UserModels.GetUser.ViewModel )
    func displayError()
}

class UserViewController: UIViewController {
    
    var presenter: UserPresentationLogic!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getUser()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let presenter = UserPresenter()
        presenter.viewController = self
        self.presenter = presenter
    }
    
    func getUser() {
        presenter.askForUser()
    }
}

extension UserViewController: UserDisplayLogic {
    func displayUser(viewModel: UserModels.GetUser.ViewModel) {
        // Exibir na tela
        activityIndicator.startAnimating()
        nameTextField.text = viewModel.user.name
        if viewModel.user.lastname == "" {
            lastnameLabel.isHidden = true
            lastNameTextField.isHidden = true
        } else {
            lastNameTextField.text = viewModel.user.lastname
        }
        //visualizar avatar
        let userAvatar = URL(string: viewModel.user.avatar)
        
        if userAvatar == nil {
            avatarImage.image = #imageLiteral(resourceName: "MaxGames")
        } else {
            avatarImage.kf.indicatorType = .activity
            avatarImage.kf.setImage(with: userAvatar, placeholder: #imageLiteral(resourceName: "MaxGames"))
        }
        birthdayTextField.text = viewModel.user.birthday
        emailTextField.text = viewModel.user.email
        addressTextField.text = viewModel.user.address
        cityTextField.text = viewModel.user.city
        countryTextField.text = viewModel.user.country
        activityIndicator.stopAnimating()
    }
    
    func displayError() {
        let alert = UIAlertController(title: "Error", message: "Could not load your info :(", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.getUser()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
