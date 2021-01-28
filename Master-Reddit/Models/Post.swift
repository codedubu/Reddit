//
//  Post.swift
//  Master-Reddit
//
//  Created by River McCaine on 1/27/21.
//  Copyright © 2021 Cameron Stuart. All rights reserved.
//

import Foundation

struct TopLevelObject: Codable {
    let data: SecondLevelObject
} // END OF STRUCT

struct SecondLevelObject: Codable {
    let children: [ThirdLevelObjects]
} // END OF STRUCT

struct ThirdLevelObjects: Codable {
    let data: Post
} // END OF STRUCT

struct Post: Codable {
    let title: String
    let ups: Int
    let thumbnail: String
} // END OF STRUCT
