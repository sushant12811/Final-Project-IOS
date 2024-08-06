import SwiftUI

struct RestaurantFavouriteListing: View {
    @ObservedObject var viewModel: RestaurantViewModel
    @State private var searchText = ""
    @State private var isAnimating = false
    
 
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(searchResults) { restaurant in
                        HStack {
                            Image(restaurant.restaurantNames)
                                .resizable()
                                .frame(width: 120, height: 120)
                                .aspectRatio(contentMode: .fit)
                            
                            VStack(alignment: .leading) {
                                Text(restaurant.restaurantNames)
                                    .font(.headline)
                                Text(restaurant.restaurantLocation)
                                    .font(.caption)
                            }
                            .frame(width: 130)
                            .foregroundColor(.darkGreen)
                            .padding(.leading, 10)
                            .padding(.bottom, 50)
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation {
                                    isAnimating.toggle()
                                    viewModel.removeFavoriteRestaurant(restaurant: restaurant)
                                }
                            }) {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25)
                                    .foregroundColor(.red)
                                    .scaleEffect(isAnimating ? 0.25 : 1.0)
                                    .animation(.easeInOut(duration: 0.3), value: isAnimating)
                            }
                            .padding(.bottom, 70)
                            .padding(.vertical, 10)
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "Search here..")
                .listStyle(PlainListStyle())
                .navigationTitle("Favorite Restaurants")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    viewModel.fetchFavoriteRestaurants()
                }
            }
        }
    }

    // Search Function
    var searchResults: [RestaurantData] {
        if searchText.isEmpty {
            return viewModel.favoriteRestaurants
        } else {
            return viewModel.favoriteRestaurants.filter { $0.restaurantNames.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

#Preview {
    RestaurantFavouriteListing(viewModel: RestaurantViewModel())
}
