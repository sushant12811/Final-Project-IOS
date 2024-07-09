//
//  RestaurantHub_IOSApp.swift
//  RestaurantHub-IOS
//
//  Created by Sushant Dhakal on 2024-07-08.
//

import SwiftUI

@main
struct RestaurantHub_IOSApp: App {
    var body: some Scene {
        WindowGroup {
            RestaurantListView(restaurantData: resData)
        }
    }
}
