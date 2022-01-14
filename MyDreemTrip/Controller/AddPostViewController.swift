

import UIKit
import Firebase
import MapKit
import CoreLocation

class AddPostViewController: UIViewController {
    var selectedPost:Aperment?
    var selectedUserImage:UIImage?
    var selectedPostImage:UIImage?
    var flag = 0
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var postImageView: UIImageView!{
        didSet {
            postImageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
            postImageView.addGestureRecognizer(tapGesture)
        }
    }
    
    
    @IBOutlet weak var priceLabel: UILabel!{
        
        
        
        didSet{
            priceLabel.text = "price".localized
        }
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.text =  "Title".localized
        }
    }
    
    
    @IBOutlet weak var locationMap: MKMapView!
    var latitude:CLLocationDegrees =  0.0
    var longitude:CLLocationDegrees =  0.0
    var locationManager  = CLLocationManager()
    let annotation = MKPointAnnotation()
    
    
    
    
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.text = "Description".localized
            
        }
    }
    
    
    
    
    @IBOutlet weak var postPriceTextField: UITextField!
    
    @IBOutlet weak var postTitleTextField: UITextField!
    @IBOutlet weak var postDescriptionTextField: UITextField!
    
    
    
    
    let activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        postImageView.layer.shadowColor = UIColor.gray.cgColor
//        postImageView.layer.shadowOpacity = 1
        postImageView.layer.shadowOffset = .zero
        postImageView.layer.cornerRadius = 10
        postImageView.layer.shadowPath = UIBezierPath(rect: postImageView.bounds).cgPath
        postImageView.layer.shouldRasterize = true
         self.postImageView.layer.cornerRadius = 10
       
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        
        locationManager.stopUpdatingLocation()
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.startUpdatingLocation()
        }
        
        if let selectedPost = selectedPost,
           let selectedImage = selectedPostImage{
            postTitleTextField.text = selectedPost.title
            postDescriptionTextField.text = selectedPost.description
            postPriceTextField.text = selectedPost.price
            postImageView.image = selectedImage
            actionButton.setTitle("Update Post".localized, for: .normal)
            let deleteBarButton = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(handleDelete))
            self.navigationItem.rightBarButtonItem = deleteBarButton
            print("*******")
        }else {
            actionButton.setTitle("Add Post".localized, for: .normal)
            self.navigationItem.rightBarButtonItem = nil
            print("))))))")
            
            
        }
    }
    
    @objc func handleDelete (_ sender: UIBarButtonItem) {
        let ref = Firestore.firestore().collection("posts")
        if let selectedPost = selectedPost {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            ref.document(selectedPost.id).delete { error in
                if let error = error {
                    print("Error in db delete",error)
                    print("&&&&&")
                }else {
                    print("%%%%%")
                    let storageRef = Storage.storage().reference(withPath: "posts/\(selectedPost.user.id)/\(selectedPost.id)")
                    storageRef.delete { error in
                        if let error = error {
                            print("Error in storage delete",error)
                        } else {
                            self.activityIndicator.stopAnimating()
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    
                }
            }
        }
    }
    
    
    
    @IBAction func gesturerAction(_ sender: UILongPressGestureRecognizer
    ) {
        
        
        
        
        let allAnnotation = locationMap.annotations
        locationMap.removeAnnotations(allAnnotation)
        let touchLocation = sender.location(in: locationMap)
        let locationCoordinate = locationMap.convert(touchLocation, toCoordinateFrom: locationMap)
        latitude = locationCoordinate.latitude
        longitude = locationCoordinate.longitude
        
        
        
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        pin.title = "location".localized
        locationMap.addAnnotation(pin)
        locationManager.startUpdatingLocation()
        
    }
    
    
    
    
    @IBAction func handleActionTouch(_ sender: Any) {
        if let image = postImageView.image,
           let imageData = image.jpegData(compressionQuality: 0.75),
           let title = postTitleTextField.text,
           let price = postPriceTextField.text,
           
            let description = postDescriptionTextField.text,
           let currentUser = Auth.auth().currentUser {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            var postId = ""
            if let selectedPost = selectedPost {
                postId = selectedPost.id
            }else {
                postId = "\(Firebase.UUID())"
            }
            let storageRef = Storage.storage().reference(withPath: "posts/\(currentUser.uid)/\(postId)")
            let updloadMeta = StorageMetadata.init()
            updloadMeta.contentType = "image/jpeg"
            storageRef.putData(imageData, metadata: updloadMeta) { storageMeta, error in
                if let error = error {
                    print("Upload error",error.localizedDescription)
                }
                storageRef.downloadURL { url, error in
                    var postData = [String:Any]()
                    if let url = url {
                        let db = Firestore.firestore()
                        let ref = db.collection("posts")
                        if let selectedPost = self.selectedPost {
                            postData = [
                                "userId":selectedPost.user.id,
                                "title":title,
                                "price":price,
                                "description":description,
                                "imageUrl":url.absoluteString,
                                "createdAt":selectedPost.createdAt ?? FieldValue.serverTimestamp(),
                                "updatedAt": FieldValue.serverTimestamp(),
                                "latitude": self.latitude,
                                "longitude": self.longitude
                            ]
                        }else {
                            postData = [
                                "userId":currentUser.uid,
                                "title":title,
                                "description":description,
                                "price":price,
                                "imageUrl":url.absoluteString,
                                "createdAt":FieldValue.serverTimestamp(),
                                "updatedAt": FieldValue.serverTimestamp(),
                                "latitude": self.latitude,
                                "longitude": self.longitude
                            ]
                        }
                        ref.document(postId).setData(postData) { error in
                            if let error = error {
                                print("FireStore Error",error.localizedDescription)
                            }
                            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                            self.navigationController?.popViewController(animated: true)
                            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController {
                                vc.modalPresentationStyle = .fullScreen
                                Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                                self.present(vc, animated: true, completion: nil)
                            }
                            
                        }
                    }
                }
            }
        }
        
    }
    
}

extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func chooseImage() {
        self.showAlert()
    }
    private func showAlert() {
        
        let alert = UIAlertController(title: "Choose Profile Picture", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        postImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
}


extension AddPostViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if flag == 0 {
            let userLocation = locations[0] as CLLocation
            latitude = userLocation.coordinate.latitude
            longitude = userLocation.coordinate.longitude
            
            print("userLocation: \(userLocation)")
            flag = 1
        }
        
        let userLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(userLocation){ (placeMarks, error) in
            if error != nil {
                print("Error")
            }
            if let placeMarks = placeMarks{
                let placeMark = placeMarks as [CLPlacemark]
                if placeMark.count>0 {
                    //  let placeMark = placeMarks[0]
                    self.locationManager.stopUpdatingLocation()
                    
                    //  let country = placeMark.country
                    
                    //  let city =placeMark.locality
                    // print(country)
                    // self.postICountryTextField.text = country ?? "Unknown"
                    //  self.postCityTextField.text = city ?? "Unknown"
                    
                    
                }}
            
            
            
        }
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        setStartingLocation(location: initialLocation, distance: 1000)
        
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        pin.title = "Current location"
        locationMap.addAnnotation(pin)
    }
    func setStartingLocation(location: CLLocation, distance: CLLocationDistance){
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        locationMap.setRegion(region, animated: true)
        
        
        
    }
    
}
