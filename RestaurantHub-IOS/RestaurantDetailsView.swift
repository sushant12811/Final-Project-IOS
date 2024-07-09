//
//  RestaurantDetails.swift
//  RestaurantHub-IOS
//
//  Created by Sushant Dhakal on 2024-07-08.
//

import SwiftUI

struct RestaurantDetailsView: View {
    var restaurantData: RestaurantData
    
    var body: some View {
        
        VStack{
            VStack (alignment: .leading){
                Image("\(restaurantData.restaurantName)")
                    .resizable()
                    .frame(height: 280)
                    .cornerRadius(5)
                    .padding(.top,80)
                    .padding(.all)
            }
            .background(.darkGreen)
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(restaurantData.restaurantName)
                    .font(.title)
            
                Text("Details")
                VStack {
                    Text(restaurantData.restaurantDetails)
                }
                .padding(.all)
                .background(.darkGreen)
                .foregroundColor(.white)
                .italic()
                .cornerRadius(12)

                Spacer()
                
                HStack{
                    Text(restaurantData.restaurantLocation)
                        .font(.body)
                    Spacer()
                    Image(systemName: "map")
                }
            }
            .padding(.all,10)
            .foregroundStyle(.darkGreen)
            .background(.lightGreen)
            .cornerRadius(10)
            Spacer()
        }.edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    RestaurantDetailsView(restaurantData: RestaurantData(restaurantName: "The FarmHouse garnden", restaurantLocation: "location", restaurantDetails: "The details"))
}
