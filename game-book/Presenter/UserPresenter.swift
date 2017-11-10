//
//  UserPresenter.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

typealias UserViewModel = UserModels.GetUser

protocol UserPresentationLogic {
    func askForUser()
}

class UserPresenter {
    var viewController: UserDisplayLogic!
    func mapUser(_ user: User) -> UserModels.GetUser.ViewModel {
        var stringDate = ""
        let strTime = user.birthday
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ"
        if let newDate = formatter.date(from: strTime!) {
            formatter.dateFormat = "dd/MM/yyyy"
            stringDate = formatter.string(from: newDate)
            
        }
       
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
//extension Date {
//    func dayFormatted() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//        dateFormatter.timeStyle = .none
//        return dateFormatter.string(from: self)
//    }
//}

