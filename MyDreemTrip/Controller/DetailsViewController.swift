//
//  DetailsViewController.swift
//  MyDreemTrip
//
//  Created by layla hakami on 23/05/1443 AH.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var selectedPost:Aperment?
    var selectedPostImage:UIImage?
    var selectedUserImage:UIImage?
    
    @IBOutlet weak var priceOutlet: UILabel! {
        didSet{
            priceOutlet.text = "price".localized
        }
    }
    @IBOutlet weak var titleOutlet: UILabel! {
        didSet{
            titleOutlet.text =  "Title".localized
        }
    }
    @IBOutlet weak var descriptionOutlet: UILabel! {
        didSet{
            descriptionOutlet.text = "Description".localized
            
        }
    }
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var imageUser: UIImageView! {
        didSet {
            imageUser.layer.borderColor = UIColor.systemBackground.cgColor
            imageUser.layer.borderWidth = 1.0
            imageUser.layer.cornerRadius = imageUser.bounds.height / 2
            imageUser.layer.masksToBounds = true
            imageUser.isUserInteractionEnabled = true
      
        }
    }
    
    @IBOutlet weak var postPriceLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDescripionLabel: UILabel!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postImageView.layer.shadowColor = UIColor.gray.cgColor
//        postImageView.layer.shadowOpacity = 1
        postImageView.layer.shadowOffset = .zero
        postImageView.layer.cornerRadius = 10
        postImageView.layer.shadowPath = UIBezierPath(rect: postImageView.bounds).cgPath
        postImageView.layer.shouldRasterize = true
         self.postImageView.layer.cornerRadius = 10
        
        if let selectedPost = selectedPost,
        let selectedImage = selectedPostImage{
            postTitleLabel.text = selectedPost.title
            postPriceLabel.text = selectedPost.price
            postDescripionLabel.text = selectedPost.description
            postImageView.image = selectedImage
            imageUser.loadImageUsingCache(with: selectedPost.user.imageUrl)
            name.text = selectedPost.user.name
            
        }

    }
    


}
