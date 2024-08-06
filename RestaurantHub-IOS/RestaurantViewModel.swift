import FirebaseFirestore
import SwiftUI
import Combine

class RestaurantViewModel: ObservableObject {
    @Published var restaurantData: [RestaurantData] = []
    @Published var favoriteRestaurants: [RestaurantData] = []
    
    private let db = Firestore.firestore()
    
    init() {
        fetchDocuments()
        fetchFavoriteRestaurants()
    }
    
    // Fetch all restaurant documents from Firestore
    func fetchDocuments() {
        db.collection("restaurants").getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            if let snapshot = snapshot {
                let data = snapshot.documents.compactMap { document in
                    try? document.data(as: RestaurantData.self)
                }
                
                DispatchQueue.main.async {
                    self?.restaurantData = data
                }
            }
        }
    }
    
    // Fetch favorite restaurant documents from Firestore
    func fetchFavoriteRestaurants() {
        db.collection("usersFav").getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                print("Error getting favorite documents: \(error)")
                return
            }
            
            if let snapshot = snapshot {
                var favoriteRestaurants: [RestaurantData] = []
                
                for document in snapshot.documents {
                    let data = document.data()
                    
                    if let restaurantName = data["name"] as? String,
                       let restaurantLocation = data["location"] as? String,
                       let restaurantDetails = data["details"] as? String {
                        let restaurantData = RestaurantData(restaurantNames: restaurantName, restaurantLocation: restaurantLocation, restaurantDetails: restaurantDetails)
                        favoriteRestaurants.append(restaurantData)
                    }
                }
                
                DispatchQueue.main.async {
                    self?.favoriteRestaurants = favoriteRestaurants
                }
            }
        }
    }
    
    // Remove favorite restaurant document from Firestore
    func removeFavoriteRestaurant(restaurant: RestaurantData) {
        db.collection("usersFav").whereField("name", isEqualTo: restaurant.restaurantNames).getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    self?.db.collection("usersFav").document(document.documentID).delete { error in
                        if let error = error {
                            print("Error deleting document: \(error)")
                            return
                        }
                        
                        DispatchQueue.main.async {
                            self?.favoriteRestaurants.removeAll(where: { $0.restaurantNames == restaurant.restaurantNames })
                        }
                    }
                }
            }
        }
    }
}
