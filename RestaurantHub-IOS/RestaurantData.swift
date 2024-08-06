import Foundation


//Structure of data with data types
struct RestaurantData: Identifiable, Codable {
    var id: UUID = UUID()
    var restaurantNames: String
    var restaurantLocation: String
    var restaurantDetails: String
    var restaurantImage: String { return restaurantNames }

    enum CodingKeys: String, CodingKey {
        case restaurantNames
        case restaurantLocation
        case restaurantDetails
    }
}
