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
//    {
//        didSet{
//    priceApartmentLabel.text = "price".localized
//        }
//    }
    
    
    @IBOutlet weak var nameApartment: UILabel!
    {
        didSet{

            nameApartment.layer.masksToBounds = true
            nameApartment.layer.cornerRadius =  20
        }
    }

    @IBOutlet weak var descriptionApartment: UILabel!
//        didSet{
//            descriptionApartment.text = "Description".localized
//        }
//    }
    
    
    
    @IBOutlet weak var userImageView: UIImageView!
    
    func configure(with post:Aperment) -> UICollectionViewCell {
        nameApartment.text = post.user.name
        priceApartmentLabel.text = post.price
        descriptionApartment.text = post.description
        userImageView.loadImageUsingCache(with: post.user.imageUrl)
        imageCollectionView.loadImageUsingCache(with: post.imageUrl)
        return self
    }
    override func prepareForReuse() {
        self.imageCollectionView.image = nil
        self.userImageView.image = nil

    }
}
