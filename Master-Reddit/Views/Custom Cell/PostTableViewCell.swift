//
//  PostTableViewCell.swift
//  Master-Reddit
//
//  Created by Cameron Stuart on 4/28/20.
//  Copyright © 2020 Cameron Stuart. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postCellImageView: UIImageView!
    @IBOutlet weak var postCellTitleLabel: UILabel!
    @IBOutlet weak var postCellUPSLabel: UILabel!
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    override func prepareForReuse() {
        postCellImageView.image = nil
    }
    
    func updateViews() {
        guard let post = post else { return }
        postCellTitleLabel.text = post.title
        postCellUPSLabel.text = "UPS: \(post.ups)"
        
        PostController.fetchThumbnail(post: post) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let thumbnail):
                    self.postCellImageView.image = thumbnail
                    print("got image")
                case .failure(let error):
                    print(error.errorDescription)
                    self.postCellImageView.image = UIImage(named: "imageNotAvailable")
                }
            }
        }
    }
}
