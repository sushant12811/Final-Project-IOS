import SwiftUI

struct RestaurantListView: View {
    @StateObject private var viewModel = RestaurantViewModel()
    @State private var searchText = ""
    @State private var hasGeneratedNotification = false

    init() {
        UISearchBar.appearance().barTintColor = UIColor.white
        UISearchBar.appearance().backgroundColor = UIColor.white
        UISearchBar.appearance().searchTextField.backgroundColor = UIColor.white
    }

    var body: some View {
        NavigationStack {
            VStack {
                List(searchResults) { restaurant in
                    NavigationLink(destination: RestaurantDetailsView(restaurantData: restaurant)) {
                        HStack {
                            Image("\(restaurant.restaurantNames)")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .aspectRatio(contentMode: .fit)
                            
                            VStack(alignment: .leading) {
                                Text(restaurant.restaurantNames)
                                    .font(.headline)
                                Text(restaurant.restaurantLocation)
                                    .font(.caption)
                            }
                            .foregroundColor(.darkGreen)
                            .padding(.bottom, 50)
                            .padding(.leading, 10)
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "Search here..")
                .listStyle(PlainListStyle())
                .navigationTitle("Restaurants")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    if !hasGeneratedNotification {
                        Task {
                            await NotificationGenerator.generateNotification(title: "Today's Best Restaurants", description: "Check out the best restaurants of the day!")
                        }
                        hasGeneratedNotification = true
                    }
                    DispatchQueue.main.async {
                        UIScrollView.appearance().keyboardDismissMode = .onDrag
                    }
                }
            }
            .toolbarBackground(Color.darkGreen, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: RestaurantFavouriteListing(viewModel: RestaurantViewModel())) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }

    // Search Function
    var searchResults: [RestaurantData] {
        if searchText.isEmpty {
            return viewModel.restaurantData
        } else {
            return viewModel.restaurantData.filter { $0.restaurantNames.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

#Preview {
    RestaurantListView()
}
