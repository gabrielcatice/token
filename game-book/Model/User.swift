//
//  User.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import UIKit

class User {
    
    let name: String!
    let lastname: String?
    let avatar: String?
    let email: String?
    let birthday: String?
    let address: String?
    let city: String?
    let country: String?
    
    init(with json: JSONObject) throws {
        
        guard let name = json["name"] as? String else {
            throw NSError()
        }
        
        self.name = name
        lastname = json["lastname"] as? String
        avatar = json["avatar"] as? String
        address = json["address"] as? String
        email = json["email"] as? String
        birthday = json["birthday"] as? String
        city = json["city"] as? String
        country = json["country"] as? String
    }
}
