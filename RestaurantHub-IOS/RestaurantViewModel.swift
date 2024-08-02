import FirebaseFirestore

import SwiftUI
import Combine

class RestaurantViewModel: ObservableObject {
    @Published var restaurantData: [RestaurantData] = []
    private let db = Firestore.firestore()

    init() {
        Task {
            await fetchDocuments()
        }
    }

    func fetchDocuments() async {
        do {
            let snapshot = try await db.collection("restaurants").getDocuments()
            let data = snapshot.documents.compactMap { document in
                try? document.data(as: RestaurantData.self)
            }
            print(data)
            DispatchQueue.main.async {
                self.restaurantData = data
            }
        } catch {
            print("Error getting documents: \(error)")
        }
    }
}
