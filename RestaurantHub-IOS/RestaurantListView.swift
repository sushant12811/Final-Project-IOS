//
//  ContentView.swift
//  RestaurantHub-IOS
//
//  Created by Sushant Dhakal on 2024-07-08.
//

import SwiftUI

struct RestaurantListView: View {
    
    @State private var searchText = ""
    
    
    var restaurantData: [RestaurantData] = []
    
    
    var body: some View {
       
            NavigationStack{
                
                List(searchResults){ resData in
                    
                    
                    NavigationLink(destination: RestaurantDetailsView(restaurantData: resData)){
                        HStack{
                            Image("\(resData.restaurantName)")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .aspectRatio(contentMode: .fit)
                            
                            VStack (alignment: .leading){
                                Text(resData.restaurantName)
                                    .font(.headline)
                                Text(resData.restaurantLocation)
                                    .font(.caption)
                            }.foregroundColor(.darkGreen)
                                .padding(.bottom,50)
                                .padding(.leading,10)
                        }
                        
                    }
                    
                    
                } .searchable(text: $searchText, prompt: "Search here..")
                    .listStyle(PlainListStyle())
                    
                
            }
            
        }
        
    
    //Search Function
    var searchResults: [RestaurantData] {
        if searchText.isEmpty {
            return restaurantData
        } else {
            return restaurantData.filter { $0.restaurantName.localizedCaseInsensitiveContains(searchText) }
            
        }
    }
    
}


#Preview {
    RestaurantListView(restaurantData:  resData)
}
