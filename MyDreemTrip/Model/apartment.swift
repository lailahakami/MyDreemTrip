import Foundation
import Firebase
struct Aperment {
    var id = ""
    var title = ""
    var description = ""
    var imageUrl = ""
    var price = ""
    var user:User
    var createdAt:Timestamp?
    
    init(dict:[String:Any],id:String,user:User) {
                if let title = dict["title"] as? String,
           let description = dict["description"] as? String,
           let imageUrl = dict["imageUrl"] as? String,
           let price = dict["price"] as? String,
            let createdAt = dict["createdAt"] as? Timestamp{
            self.price = price
            self.title = title
            self.description = description
            self.imageUrl = imageUrl
            self.createdAt = createdAt
        }
        self.id = id
        self.user = user
    }
}
