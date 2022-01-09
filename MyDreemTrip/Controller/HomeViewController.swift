
import UIKit
import Firebase
import CoreMedia

class HomeViewController: UIViewController {
    
    var posts = [Aperment]()
    var selectedPost:Aperment?
    var selectedPostImage:UIImage?
    var filterdPost:[Aperment] = []
    var selectedUserImage:UIImage?
    let searchController = UISearchController(searchResultsController: nil)
    
    
   
    
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
   {
        didSet {
        postsCollectionView.delegate = self
        postsCollectionView.dataSource = self
//            postsCollectionView.backgroundColor = .systemFill
        }
    }
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
        
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        

        
    }

    func getPosts() {
        let ref = Firestore.firestore()
        ref.collection("posts").order(by: "createdAt",descending: true).addSnapshotListener { snapshot, error in
            if let error = error {
                print("DB ERROR Posts",error.localizedDescription)
            }
            if let snapshot = snapshot {
                print("POST CANGES:",snapshot.documentChanges.count)
                snapshot.documentChanges.forEach { diff in
                    let postData = diff.document.data()
                    switch diff.type {
                    case .added :
                        
                        if let userId = postData["userId"] as? String {
                            ref.collection("users").document(userId).getDocument { userSnapshot, error in
                                if let error = error {
                                    print("ERROR user Data",error.localizedDescription)
                                }
                                if let userSnapshot = userSnapshot,
                                   let userData = userSnapshot.data(){
                                    let user = User(dict:userData)
                                    let post = Aperment(dict:postData,id:diff.document.documentID,user:user)
                                      self.posts.insert(post,at:0)
                                    DispatchQueue.main.async {
                                        self.postsCollectionView.reloadData()
                                    }

                                        }

                            }
                                }
                            
                        
                    case .modified:
                        let postId = diff.document.documentID
                        if let currentPost = self.posts.first(where: {$0.id == postId}),
                           let updateIndex = self.posts.firstIndex(where: {$0.id == postId}){
                            let newPost = Aperment(dict:postData, id: postId, user: currentPost.user)
                            self.posts[updateIndex] = newPost
                            DispatchQueue.main.async {
                                self.postsCollectionView.reloadData()
                            }
                            

                    }
                    case .removed:
                        let postId = diff.document.documentID
                        if let deleteIndex = self.posts.firstIndex(where: {$0.id == postId}){
                            self.posts.remove(at: deleteIndex)
                            DispatchQueue.main.async {
                                self.postsCollectionView.reloadData()
                            }
//                                self.packagesCollectionView.beginUpdates()
//                            self.postsCollectionView.deleteItems(at: [IndexPath(item: deleteIndex, section: 0)])
//                            self.packagesCollectionView.endUpdates()
                        
                        }
            }
        }
    }
        }
            }
    
     
    @IBAction func handleLogout(_ sender: Any) {
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
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let identifier = segue.identifier {
        if identifier == "toPostVC" {
            let vc = segue.destination as! AddPostViewController
            vc.selectedPost = selectedPost
            vc.selectedPostImage = selectedPostImage
            vc.selectedUserImage = selectedUserImage
        }else if identifier == "toDetailsVC" {
            let vc = segue.destination as! DetailsViewController
            vc.selectedPost = selectedPost
vc.selectedPostImage = selectedPostImage
            vc.selectedUserImage = selectedUserImage
            
        }
    }
    
}
}
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController : UISearchController) {
        filterdPost = posts.filter({selectedPost in
            return selectedPost.title.lowercased().contains(searchController.searchBar.text!.lowercased()) ||
            selectedPost.description.lowercased().contains(searchController.searchBar.text!.lowercased()) ||
            selectedPost.user.name.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
        postsCollectionView.reloadData()


    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return posts.count
        return  searchController.isActive ?filterdPost.count : posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = searchController.isActive ? filterdPost[indexPath.row] : posts[indexPath.row]
                   
        cell.backgroundColor = .systemBackground
               print("...", posts[indexPath.row])
               cell.layer.borderColor = UIColor.systemBackground.cgColor
               cell.layer.borderWidth = 4.0
               cell.layer.cornerRadius = 20
               
        return cell.configure(with: posts[indexPath.row])
        
        
        
        
//        cell.backgroundColor = .systemFill
        
        return cell.configure(with: posts[indexPath.row])
        
        

    }
        
        
    }
    
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionView, sizeForItemAT indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.495, height: self.view.frame.width * 0.45)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    func collectionView(_collectionView: UICollectionView,layout colletionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        
        
        
        return 1
    }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionView, insetForSrctionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 1, left: 2, bottom: 1, right: 2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PostCell
        selectedPostImage = cell.imageCollectionView.image
        selectedPost = posts[indexPath.row]
        if let currentUser = Auth.auth().currentUser,
           currentUser.uid == posts[indexPath.row].user.id{
            performSegue(withIdentifier: "toPostVC", sender: self)
        }else {
            performSegue(withIdentifier: "toDetailsVC", sender: self)
        }
    }
}



    


