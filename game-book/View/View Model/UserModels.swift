//
//  UserViewModels.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

struct DisplayedUser {
    let name: String
    let lastname: String
    let avatar: String
    let email: String
    let birthday: String
    let address: String
    let city: String
    let country: String
}
struct UserModels {
    struct GetUser {
        struct ViewModel {
            let user: DisplayedUser
        }
        
    }
}
