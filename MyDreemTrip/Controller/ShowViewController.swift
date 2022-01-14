//
//  ShowViewController.swift
//  MyDreemTrip
//
//  Created by layla hakami on 11/06/1443 AH.
//

import UIKit

class ShowViewController: UIViewController {
    
    
    @IBOutlet weak var describeLabel: UILabel!  {
        didSet{
            describeLabel.text = "Are you having a hard time choosing your old destination".localized
        }
    }
    @IBOutlet weak var describeShowLabel: UILabel!  {
        didSet{
            describeShowLabel.text = "We have the solution".localized
        }
    }
    @IBOutlet weak var joinButton: UIButton! {
        didSet{
            joinButton.setTitle(NSLocalizedString("Join us", tableName: "Localizaple", comment: ""),for:  .normal)
        }
        
    }
    
    
}
