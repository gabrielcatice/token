//
//  UserViewController.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import UIKit
import Kingfisher

//  This procotol receive data from the presenter
protocol UserDisplayLogic {
    func displayUser(viewModel: UserModels.GetUser.ViewModel )
    func displayError()
}

class UserViewController: UIViewController {
    
    var presenter: UserPresentationLogic!
    
    // Textfields
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var avatarImage: UIImageView!
    
    // Labels
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
        //  Setting up the presenter
        let presenter = UserPresenter()
        presenter.viewController = self
        self.presenter = presenter
    }
    
    func getUser() {
        
        //  Call the method to request data on presenter
        presenter.askForUser()
    }
}

//  Extension from MainDisplayLogic to set the data came from the presenter in the screen
extension UserViewController: UserDisplayLogic {
    func displayUser(viewModel: UserModels.GetUser.ViewModel) {
       
        let userAvatar = URL(string: viewModel.user.avatar)
        activityIndicator.startAnimating()
        
        // Verifying if data is null to hide objects from the screen
        if viewModel.user.name == "" {
            nameLabel.isHidden = true
            nameTextField.isHidden = true
        } else {
            nameTextField.text = viewModel.user.name
        }
        
        if viewModel.user.lastname == "" {
            lastnameLabel.isHidden = true
            lastNameTextField.isHidden = true
        } else {
            lastNameTextField.text = viewModel.user.lastname
        }
        
        if viewModel.user.birthday == "" {
            birthdayLabel.isHidden = true
            birthdayTextField.isHidden = true
        } else {
            birthdayTextField.text = viewModel.user.birthday
        }
        
        if viewModel.user.email == "" {
            emailLabel.isHidden = true
            emailTextField.isHidden = true
        } else {
            emailTextField.text = viewModel.user.email
        }
        
        if viewModel.user.address == "" {
            addressLabel.isHidden = true
            addressTextField.isHidden = true
        } else {
            addressTextField.text = viewModel.user.address
        }
        
        if viewModel.user.city == "" {
            cityLabel.isHidden = true
            cityTextField.isHidden = true
        } else {
            cityTextField.text = viewModel.user.city
        }
        
        if viewModel.user.country == "" {
            countryLabel.isHidden = true
            countryTextField.isHidden = true
        } else {
            countryTextField.text = viewModel.user.country
        }
        
        avatarImage.kf.indicatorType = .activity
        avatarImage.kf.setImage(with: userAvatar, placeholder: #imageLiteral(resourceName: "MaxGames"))
        
        activityIndicator.stopAnimating()
    }
    
    func displayError() {
        
        //  Case failure: error treatments
        let alert = UIAlertController(title: "Sorry :(", message: "Could not load your info", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Try Again", style: .cancel) { _ in
            self.getUser()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
            self.activityIndicator.stopAnimating()
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
