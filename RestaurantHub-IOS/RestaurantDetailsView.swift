import SwiftUI

struct RestaurantDetailsView: View {
    var restaurantData: RestaurantData
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Image("\(restaurantData.restaurantNames)")
                    .resizable()
                    .frame(height: 280)
                    .cornerRadius(5)
                    .padding(.top, 80)
                    .padding(.all)
            }
            .background(Color.darkGreen)
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(restaurantData.restaurantNames)
                    .font(.title)
            
                Text("Details")
                VStack {
                    Text(restaurantData.restaurantDetails)
                }
                .padding(.all)
                .background(Color.darkGreen)
                .foregroundColor(.white)
                .italic()
                .cornerRadius(12)

                Spacer()
                
                HStack {
                    Text(restaurantData.restaurantLocation)
                        .font(.body)
                    Spacer()
                    Image(systemName: "map")
                }
            }
            .padding(.all, 10)
            .foregroundColor(Color.darkGreen)
            .background(Color.lightGreen)
            .cornerRadius(10)
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .navigationTitle(restaurantData.restaurantNames)
    }
}

#Preview {
    RestaurantDetailsView(restaurantData: RestaurantData(restaurantNames: "The FarmHouse Garden", restaurantLocation: "location", restaurantDetails: "The details"))
}
