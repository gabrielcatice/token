//
//  Result.swift
//  game-book
//
//  Created by Gabriel Catice on 11/8/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//  This enum helps to map cases os sucess or failure along the code. Help to send the information through the flow

import Foundation


enum Result<T> {
    case success(T)
    case failure(Error)
}
