//
//  Post.swift
//  Master-Reddit
//
//  Created by Cameron Stuart on 4/28/20.
//  Copyright © 2020 Cameron Stuart. All rights reserved.
//

import Foundation

struct Post {
    let title: String
    let ups: Int
    let thumbnail: String
}

extension Post {
    
    init?(dictionary: [String : Any]) {
        
        guard let dataDictionary = dictionary["data"] as? [String : Any],
            let title = dataDictionary["title"] as? String,
            let ups = dataDictionary["ups"] as? Int,
            let thumbnail = dataDictionary["thumbnail"] as? String else { return nil }
        
        self.title = title
        self.ups = ups
        self.thumbnail = thumbnail
    }
}
