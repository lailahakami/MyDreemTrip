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
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postPriceLabel: UILabel!
    
    @IBOutlet weak var postTitleLabel: UILabel!
    
    
    @IBOutlet weak var postDescripionLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedPost = selectedPost,
        let selectedImage = selectedPostImage{
            postTitleLabel.text = selectedPost.title
            postDescripionLabel.text = selectedPost.description
            postImageView.image = selectedImage
        }

    }
    


}
