//
//  GameService.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

class GameService {
    
    static let path = URL.Game.self
    static func fetch(completion: @escaping (Result<[Game]>) -> Void) {
        Rest.getList(path.game) {
            switch $0 {
            case .success(let jsonArray):
                do {
                    var array = [Game]()
                    for obj in jsonArray {
                        let game = try Game(with: obj)
                        array.append(game)
                    }
                    completion(.success(array))
                    
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
