//
//  PostListTableViewController.swift
//  Master-Reddit
//
//  Created by Cameron Stuart on 4/28/20.
//  Copyright © 2020 Cameron Stuart. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {

    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PostController.fetchPosts { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.tableView.reloadData()
                case .failure(let error):
                    print("-----------------BOOO ERROR-----------------")
                    print(error)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }

        let post = self.posts[indexPath.row]
        
        cell.postCellTitleLabel.text = post.title
        cell.postCellUPSLabel.text = "UPS: \(post.ups)"
        cell.postCellImageView.image = nil
        
        PostController.fetchThumbnail(post: post) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let thumbnail):
                    cell.postCellImageView.image = thumbnail
                    print("got image")
                case .failure(let error):
                    print(error.errorDescription)
                    cell.postCellImageView.image = UIImage(named: "imageNotAvailable")
                }
            }
        }

        return cell
    }
}
