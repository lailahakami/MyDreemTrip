//
//  ProfileViewController.swift
//  MyDreemTrip
//
//  Created by layla hakami on 12/06/1443 AH.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {


    @IBOutlet weak var imageProfilUser: UIImageView! {
        didSet {
            imageProfilUser.layer.borderColor = UIColor.systemBackground.cgColor
            imageProfilUser.layer.borderWidth = 1.0
            imageProfilUser.layer.cornerRadius = imageProfilUser.bounds.height / 2
            imageProfilUser.layer.masksToBounds = true
            imageProfilUser.isUserInteractionEnabled = true
      
        }
    }
    
    @IBOutlet weak var imageHeader: UIImageView! {
        didSet{
            imageHeader.layer.borderColor = UIColor.tertiarySystemBackground.cgColor
            imageHeader.layer.borderWidth = 0
            imageHeader.layer.cornerRadius = 20
            imageHeader.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            imageHeader.layer.masksToBounds = true
            imageHeader.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var nameProfileUser: UILabel!
    @IBOutlet weak var idProfileUser: UILabel!
    @IBOutlet weak var phoneNumberProfileUser: UILabel!
    @IBOutlet weak var emailProfileUser: UILabel!
    @IBOutlet weak var logoutLabel: UIButton! {
        didSet{
            logoutLabel.setTitle(NSLocalizedString("logout", tableName: "Localizaple", comment: ""),for:  .normal)
        }
    }
        
    @IBOutlet weak var viewHeader: UIView! {
        didSet{
            viewHeader.layer.borderColor = UIColor.tertiarySystemBackground.cgColor
            viewHeader.layer.borderWidth = 0
            viewHeader.layer.cornerRadius = 20
            viewHeader.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            viewHeader.layer.masksToBounds = true
            viewHeader.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var viewProfile: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewProfile.layer.shadowColor = UIColor.gray.cgColor
        viewProfile.layer.shadowOffset = .zero
        viewProfile.layer.cornerRadius = 10
        viewProfile.layer.shadowPath = UIBezierPath(rect: viewProfile.bounds).cgPath
        viewProfile.layer.shouldRasterize = true
           self.viewProfile.layer.cornerRadius = 10
        
        imageProfilUser.layer.shadowColor = UIColor.gray.cgColor
        imageProfilUser.layer.shadowOffset = .zero
        imageProfilUser.layer.cornerRadius = 10
        imageProfilUser.layer.shadowPath = UIBezierPath(rect: imageProfilUser.bounds).cgPath
        imageProfilUser.layer.shouldRasterize = true
           self.imageProfilUser.layer.cornerRadius = 10
        
              getUser()
              
              // Funcation add data User in Profile ...
              
              func getUser() {
                  let ref = Firestore.firestore()
                  if let currentUser = Auth.auth().currentUser{
                      ref.collection("users").document(currentUser.uid).addSnapshotListener {
                          snapshot, error in
                          if let error = error {
                              print("", error.localizedDescription)
                          }
                          if let snapshot = snapshot, let userDate = snapshot.data() {
                              let user = User(dict: userDate)
                              self.imageProfilUser.loadImageUsingCache(with: user.imageUrl)
                              self.nameProfileUser.text = user.name
                              self.emailProfileUser.text = user.email
    
                          }
                          
                      }
                  }
              }
              
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
                do {
            try Auth.auth().signOut()
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LandingNavigationController") as? UINavigationController {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        } catch  {
            print("ERROR in signout",error.localizedDescription)
        }
        
    }
    }
