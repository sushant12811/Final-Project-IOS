//
//  RestaurantData.swift
//  RestaurantHub-IOS
//
//  Created by Sushant Dhakal on 2024-07-08.
//

import Foundation

struct RestaurantData: Identifiable
{
    var id = UUID()
    var restaurantName : String
    var restaurantLocation : String
    var restaurantDetails : String
    var restaurantImage : String {return restaurantName}
}

let resData =
[
    RestaurantData(restaurantName: "The Farmhouse Restaurant", restaurantLocation: "268 Bradford St nBarrie", restaurantDetails: "Homey eatery with multiple rooms offering Canadian cuisine and patios overlooking the bay. Service Options: Has outdoor seating, Has fireplace and Serves great cocktails"),
    RestaurantData(restaurantName: "Casa Mia Barrie", restaurantLocation: "88 Dunlop St Barrie", restaurantDetails: "Warm, spacious fixture providing traditional Greek and Italian cuisine in a low-lit setting. Service options: Serves vegetarian dishes, Has kids menu"),
    RestaurantData(restaurantName: "Grillicious Restaurant and Wine Bar", restaurantLocation: "2 Marsellus Dr Unit 1 and 2", restaurantDetails: "Service options: Has outdoor seating, Serves great cocktails, Serves vegan dishes"),
    RestaurantData(restaurantName: "Bâton Rouge Grillhouse and Bar", restaurantLocation: "336 Bayfield St Barrie", restaurantDetails: "Service options: Has outdoor seating, Has fireplace, Serves great cocktails"),
    RestaurantData(restaurantName: "Taj Bistro", restaurantLocation: "140 Dunlop St E #101 Barrie", restaurantDetails: "Service options: Serves vegan dishes, Has Wi-Fi, High chairs available"),
    RestaurantData(restaurantName: "Il Buco", restaurantLocation: "31 Dunlop St E Barrie", restaurantDetails: "Polished venue offering traditional Italian fare, including pasta, veal and seafood, plus lake views. Service options: Reservations required, Has outdoor seating"),
    RestaurantData(restaurantName: "Zio's Italian Comfort Food", restaurantLocation: "110 Anne St S Barrie", restaurantDetails: "A menu with an array of small and shared Italian-inspired dishes in a relaxed space with green walls. Service options: Serves vegetarian dishes, Has kids menu"),
    RestaurantData(restaurantName: "Cottage Canoe Restaurant", restaurantLocation: "Dunlop St W Barrie", restaurantDetails: "Rustic, relaxed set-up for hearty breakfast, international favorites and desserts plus beer and wine.Service options: Has fireplace, Serves vegetarian dishes, Has kids menu"),
    RestaurantData(restaurantName: "The Canadian Brewhouse (Barrie)", restaurantLocation: "Park Pl Blvd Barrie", restaurantDetails: "Service options: Has outdoor seating, Serves great cocktails, Good for watching sports"),
    RestaurantData(restaurantName: "Symposium Cafe Restaurant Barrie", restaurantLocation: "Cundles Rd E Barrie", restaurantDetails: "Breakfast standards and gourmet comfort food served in a stylish space with a Renaissance theme. Service options: Serves happy hour food, Serves vegan dishes, Has Wi-Fi"),
    RestaurantData(restaurantName: "Bull and Barrel Pub", restaurantLocation: "Cedar Pointe Dr Barrie", restaurantDetails: "Beer, cocktails and English pub grub in a relaxed setting with dark-wood decor and weekend live music. Service options: Has outdoor seating, Serves great cocktails, Has live music"),
    RestaurantData(restaurantName: "Chaopaya Thai Restaurant", restaurantLocation: "Dunlop St E Barrie", restaurantDetails: "Thai curries, noodles and rice dishes in a cozy, colourful spot filled with traditional art and decor. Service options: Has outdoor seating, Serves vegan dishes, High chairs available")

    
]
