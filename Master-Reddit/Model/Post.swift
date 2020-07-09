//
//  Post.swift
//  Master-Reddit
//
//  Created by Cameron Stuart on 4/28/20.
//  Copyright © 2020 Cameron Stuart. All rights reserved.
//

import Foundation

struct PostTopLevelObject: Codable {
    let data: PostSecondLevelObject
}

struct PostSecondLevelObject: Codable {
    let children: [PostThirdLevelObject]
}

struct PostThirdLevelObject: Codable {
    let data: Post
}

struct Post: Codable {
    let title: String
    let ups: Int
    let thumbnail: String
}
