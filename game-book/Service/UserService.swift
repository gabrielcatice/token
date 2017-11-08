//
//  UserService.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

class UserService {
    static let path = URL.User
    static func fetch(completion: @escaping (Result<User>) -> Void) {
        Rest.get(path.user) {
            switch $0 {
            case .sucess(let json):
                do {
                   
                    }
                    completion(.sucess())

            } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
