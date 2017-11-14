//
//  GameService.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

class GameService {
    
    static let path = URLs.Game.self
    
    //services layer implementation
    
    //This fuction receivs and Id as paramter and then extract a single object from the array of json objects came from API
    static func getItem(with id: Int, completion: @escaping (Result<Game>) -> Void){
        GameService.fetch { (result) in
            switch result {
            case .success(let games):
                if let game = games.first(where: {$0.id == id}) {
                    completion(.success(game))
                } else {
                    completion(.failure(NSError()))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func fetch(completion: @escaping (Result<[Game]>) -> Void) {
        Rest.getList(path.game) {
            switch $0 {
            case .success(let jsonArray):
                do {
                    var array = [Game]()
                    for obj in jsonArray { //loops through each objct JSON
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
