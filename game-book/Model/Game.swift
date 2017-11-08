//
//  Game.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import UIKit

struct Game {
    
    let id: Int!
    let name: String?
    let imageURL: String?
    let releaseDate: String?
    let trailerURL: String?
    let platforms: [String]?
    
    init(with json: JSONObject) throws {
        guard let id = json["id"] as? Int else {
            throw NSError()
        }
        
        self.id = id
        name = json["name"] as? String
        imageURL = json["image"] as? String
        releaseDate = json["release_date"] as? String
        trailerURL = json["trailer"] as? String
        platforms = json["platforms"] as? [String]
    }
}
