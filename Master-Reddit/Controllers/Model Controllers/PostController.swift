//
//  PostController.swift
//  Master-Reddit
//
//  Created by River McCaine on 1/27/21.
//  Copyright © 2021 Cameron Stuart. All rights reserved.
//

import UIKit

class PostController {
    
    // Trying to get here -> https://www.reddit.com/r/funny.json
    
    static let baseURL = URL(string: "https://www.reddit.com")
    // https://www.reddit.com
    
    static let redditEndPoint = "r"
    // r
    
    static let funny = "funny"
    // funny
    
    static let jsonExtension = "json"
    // json
    
    static func fetchPosts(completion: @escaping (Result<[Post], PostError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        // https://www.reddit.com/
        
        let redditURL = baseURL.appendingPathComponent(redditEndPoint)
        // https://www.reddit.com/r
        
        let funnyURL = redditURL.appendingPathComponent(funny)
        // https://www.reddit.com/r/funny
        
        let finalURL = funnyURL.appendingPathExtension(jsonExtension)
        // https://www.reddit.com/r/funny.json
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            if let error = error {
                print("========= ERROR =========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("========= ERROR =========")
                
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                
                var posts: [Post] = []
                
                // Iterates through every single Third level object (children).
                for object in topLevelObject.data.children {
                    // We set a post to be object.date, date has all the things we need in a post.
                    let post = object.data
                    // At the end of the loop add the post to the posts array.
                    posts.append(post)
                }
                completion(.success(posts))
                
            } catch {
                    print("========= ERROR =========")
                    print("Function: \(#function)")
                    print("Error: \(error)")
                    print("Description: \(error.localizedDescription)")
                    print("========= ERROR =========")
                
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }

    static func fetchThumbnail(for post: Post, completion: @escaping (Result<UIImage, PostError>) -> Void) {
        
        guard let url = URL(string: post.thumbnail) else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("========= ERROR =========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("========= ERROR =========")
                
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let thumbnail = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            
            completion(.success(thumbnail))
            
        }.resume()
    }
} // END OF CLASS 
