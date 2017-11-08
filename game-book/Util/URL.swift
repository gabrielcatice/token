//
//  URL.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

struct URL {
    
    static let baseURL = "https://dl.dropboxusercontent.com/s"
    
    struct User {
        static let user = "\(baseURL)/fiqendqz4l1xk61/userinfo"
    }
    struct Game {
        static let game = "\(baseURL)/1b7jlwii7jfvuh0/games"
    }
}

