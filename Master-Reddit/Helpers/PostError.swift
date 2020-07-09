//
//  PostError.swift
//  Master-Reddit
//
//  Created by Cameron Stuart on 4/28/20.
//  Copyright © 2020 Cameron Stuart. All rights reserved.
//

import Foundation

enum PostError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
 
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "The server failed to reach the necessary URL."
        case .thrownError(let error):
            return "Opps, there was an error: \(error.localizedDescription)"
        case .noData:
            return "The server failed to load any data."
        case .unableToDecode:
            return "There was an error when trying to load the data."
        }
    }
}
