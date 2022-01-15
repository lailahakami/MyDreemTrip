//
//  PostCell.swift
//  MyDreemTrip
//
//  Created by layla hakami on 25/05/1443 AH.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCollectionView: UIImageView!
    
    @IBOutlet weak var titleApartmentLabel: UILabel!
    
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
    
    
    
    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            userImageView.layer.borderColor = UIColor.systemGreen.cgColor
            userImageView.layer.borderWidth = 1.0
            userImageView.layer.cornerRadius = userImageView.bounds.height / 2
            userImageView.layer.masksToBounds = true
            userImageView.isUserInteractionEnabled = true
        }
    }
    
    func configure(with post:Aperment) -> UICollectionViewCell {
//        nameApartment.text = post.user.name
        priceApartmentLabel.text = post.price
        descriptionApartment.text = post.description
        titleApartmentLabel.text = post.title
        
//        userImageView.loadImageUsingCache(with: post.user.imageUrl)
        imageCollectionView.loadImageUsingCache(with: post.imageUrl)
        return self
    }
    override func prepareForReuse() {
        self.imageCollectionView.image = nil
//        self.userImageView.image = nil

    }
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
        imageCollectionView.layer.shadowColor = UIColor.gray.cgColor
//        imageCollectionView.layer.shadowOpacity = 1
        imageCollectionView.layer.shadowOffset = .zero
        imageCollectionView.layer.cornerRadius = 10
        imageCollectionView.layer.shadowPath = UIBezierPath(rect: imageCollectionView.bounds).cgPath
        imageCollectionView.layer.shouldRasterize = true
           self.imageCollectionView.layer.cornerRadius = 10
       }
}
