//
//  User.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//


//{
//    "name":"Brynn",
//    "lastname":"",
//    "avatar":"https://www.dropbox.com/s/5b0dybi8navl34q/avatar.jpg?dl=1",
//    "email":"vitae@sitamet.ca",
//    "birthday":"1980-09-17T22:56:44-07:00",
//    "address":"P.O. Box 416, 557 Proin Ave",
//    "city":"San Pietro Mussolino",
//    "country":"Bahamas",
//    "token": "d6a4b2213394132a520b93ee3d7510d0"
//}

import UIKit

class User {
    

    var name: String!
    var lastname: String?
    var avatar: String?
    var email: String?
    var birthday: String?
    var address: String?
    var city: String?
    var country: String?
    
    init(with json: JSONObject) throws {
        guard let name = json["name"] as? String else {
            throw NSError()
        }
        self.name = name
        lastname = json["lastname"] as? String
        avatar = json["avatar"] as? String
        email = json["email"] as? String
        birthday = json["birthday"] as? String
        city = json["city"] as? String
        country = json["country"] as? String
    }
}
