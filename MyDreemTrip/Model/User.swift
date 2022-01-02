
import Foundation
import Firebase
struct User {
    var id = ""
    var name = ""
    var imageUrl = ""
    var email = ""
    init(dict:[String:Any]) {
           
         if  let name = dict["name"] as? String,
           let imageUrl = dict["imageUrl"] as? String,
             let id = dict["userId"] as? String,
           let email = dict["email"] as? String {
            self.name = name         
            self.email = email
            self.imageUrl = imageUrl
             self.id = id
        }
    }
}
