//
//  APIResult.swift
//  SkipMobile
//
//  Created by Angelo Lara dos Santos on 17/03/2018.
//  Copyright © 2018 angelo. All rights reserved.
//

import Foundation


enum APIResult<Value> {
    case Success(value: Value)
    case Failure(error: NSError)
    
    init(_ f: () throws -> Value) {
        do {
            let value = try f()
            self = .Success(value: value)
        } catch let error as NSError {
            self = .Failure(error: error)
        }
    }
    
    func unwrap() throws -> Value {
        switch self {
        case .Success(let value):
            return value
        case .Failure(let error):
            throw error
        }
    }
}
