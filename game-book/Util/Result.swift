//
//  Result.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import Foundation

enum Result<T> {
    case sucess(T)
    case failure(Error)
}
