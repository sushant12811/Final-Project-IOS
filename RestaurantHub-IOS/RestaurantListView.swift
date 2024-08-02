import SwiftUI

struct RestaurantListView: View {
    @StateObject private var viewModel = RestaurantViewModel()
    @State private var searchText = ""

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
                    // Ensure search bar is visible on appear
                    DispatchQueue.main.async {
                        UIScrollView.appearance().keyboardDismissMode = .onDrag
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
