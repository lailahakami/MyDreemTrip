import Foundation
import Firebase
struct Aperment {
    var id = ""
    var title = ""
    var description = ""
    var imageUrl = ""
    var price = ""
    var latitude = 0.0
    var longitude = 0.0
   // var city = ""
   // var country = ""
    var user:User
    var createdAt:Timestamp?
    
    init(dict:[String:Any],id:String,user:User) {
                if let title = dict["title"] as? String,
           let description = dict["description"] as? String,
                   
      //  let country = dict["country"] as? String,
                   
                 //  let city = dict["city"] as? String,
                   
                   let latitude = dict["latitude"] as? Double,
                   
                   let longitude = dict["longitude"] as? Double,
                   
           let imageUrl = dict["imageUrl"] as? String,
           let price = dict["price"] as? String,
            let createdAt = dict["createdAt"] as? Timestamp{
            self.price = price
            self.title = title
            self.description = description
                  //  self.city = city
                 //   self.country = country
                    self.latitude = latitude
                    self.longitude = longitude
                            self.imageUrl = imageUrl
            self.createdAt = createdAt
        }
        self.id = id
        self.user = user
    }
}
