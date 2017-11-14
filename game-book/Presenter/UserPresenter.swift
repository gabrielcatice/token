//
//  UserPresenter.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

typealias UserViewModel = UserModels.GetUser

//  Procotol who decides whose methods will be shown to the UserViewController
protocol UserPresentationLogic {
    func askForUser()
}

class UserPresenter {
    var viewController: UserDisplayLogic!
    func mapUser(_ user: User) -> UserModels.GetUser.ViewModel {
        
        //  Formatting the date to present in the correct format
        var stringDate = ""
        let strTime = user.birthday
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ"
        if let newDate = formatter.date(from: strTime!) {
            formatter.dateFormat = "dd/MM/yyyy"
            stringDate = formatter.string(from: newDate)
        }
        
        //  Mapping the object came from service response to a view model
        let user = DisplayedUser (name: user.name ?? "",
                             lastname: user.lastname ?? "",
                             avatar: user.avatar ?? "",
                             email: user.email ?? "",
                             birthday: stringDate,
                             address: user.address ?? "",
                             city: user.city ?? "",
                             country: user.country ?? "")
        
        let viewModel = UserModels.GetUser.ViewModel(user: user)
        return viewModel
    }
}

//  Implementation of MainPresentationLogic: Does a request to the services layer and map its result
extension UserPresenter: UserPresentationLogic {
    func askForUser() {
        UserService.fetch { (result) in
            switch result {
            case .success(let user):
                self.viewController.displayUser(viewModel: self.mapUser(user))
            case .failure( _):
                self.viewController.displayError()
            }
        }
    }
}
