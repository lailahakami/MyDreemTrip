//
//  PostCell.swift
//  MyDreemTrip
//
//  Created by layla hakami on 24/05/1443 AH.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    @IBOutlet weak var postTitleLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    func configure(with post:Aperment) -> UITableViewCell {
        postTitleLabel.text = post.title
        postDescriptionLabel.text = post.description
        postImageView.loadImageUsingCache(with: post.imageUrl)
        userNameLabel.text = post.user.name
        userImageView.loadImageUsingCache(with: post.user.imageUrl)
        return self
    }
    
    override func prepareForReuse() {
        userImageView.image = nil
        postImageView.image = nil
    }
}

