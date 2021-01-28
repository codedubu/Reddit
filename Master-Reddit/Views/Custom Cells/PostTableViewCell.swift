//
//  PostTableViewCell.swift
//  Master-Reddit
//
//  Created by Cameron Stuart on 4/28/20.
//  Copyright © 2020 Cameron Stuart. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var postCellImageView: UIImageView!
    @IBOutlet weak var postCellTitleLabel: UILabel!
    @IBOutlet weak var postCellUPSLabel: UILabel!
    
    // MARK: - Properties
    // Landing Pad
    var post: Post? {
        // Property observer: upon it changing, it'll run whatever is inside the didSet.
        didSet {
            updateViews()
        }
    }
    
    override func prepareForReuse() {
        postCellImageView.image = UIImage(named: "imageNotAvailable")
    }
    
    func updateViews() {
        guard let post = post else { return }
        postCellTitleLabel.text = post.title
        postCellUPSLabel.text = "👍🏼 \(post.ups)"
        PostController.fetchThumbnail(for: post) { (result) in
            switch result {
            case .success(let thumbnail):
                DispatchQueue.main.async {
                    self.postCellImageView.image = thumbnail
                }
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
    
} // END OF CLASS

// Only need DispatchQueue for UI changes.
