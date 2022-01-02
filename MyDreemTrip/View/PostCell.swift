//
//  PostCell.swift
//  MyDreemTrip
//
//  Created by layla hakami on 25/05/1443 AH.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCollectionView: UIImageView!
    
    @IBOutlet weak var priceApartmentLabel: UILabel!
    
    
    @IBOutlet weak var nameApartment: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    func configure(with post:Aperment) -> UICollectionViewCell {
        nameApartment.text = post.user.name
        priceApartmentLabel.text = post.price
        userImageView.loadImageUsingCache(with: post.user.imageUrl)
        imageCollectionView.loadImageUsingCache(with: post.imageUrl)
        return self
    }
    override func prepareForReuse() {
        self.imageCollectionView.image = nil
        self.userImageView.image = nil

    }
}