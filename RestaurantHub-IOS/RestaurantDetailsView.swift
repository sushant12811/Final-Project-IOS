import SwiftUI
import FirebaseFirestore

struct RestaurantDetailsView: View {
    var restaurantData: RestaurantData
    @State private var isFavorite: Bool = false
    @State private var isAnimating = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

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
                HStack {
                    Text(restaurantData.restaurantNames)
                        .font(.title)
                    Spacer()
                }
                
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                        Text("Back")
                            .foregroundColor(.white)
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart.fill")
                        .foregroundColor(isFavorite ? .red : .gray)
                        .scaleEffect(isAnimating ? 1.5 : 1.0)
                        .animation(.easeInOut(duration: 0.3), value: isAnimating)
                }
            }
        }
        .onAppear {
            checkIfFavorite()
        }
    }

    // Animation in toggle
    private func animateFavoriteToggle() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isAnimating = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.3)) {
                isAnimating = false
            }
        }
    }

    // Toggling favIcon
    private func toggleFavorite() {
        animateFavoriteToggle()
        
        if isFavorite {
            removeFromFavorites()
        } else {
            addToFavorites()
        }
    }

    // Checking Favourites
    private func checkIfFavorite() {
        let db = Firestore.firestore()
        let docRef = db.collection("usersFav").document(restaurantData.restaurantNames)

        docRef.getDocument { document, error in
            if let document = document, document.exists {
                isFavorite = true
            } else {
                isFavorite = false
            }
        }
    }

    // Saving data to firebase
    private func addToFavorites() {
        let db = Firestore.firestore()
        let favoriteData: [String: Any] = [
            "name": restaurantData.restaurantNames,
            "location": restaurantData.restaurantLocation,
            "details": restaurantData.restaurantDetails
        ]
        
        db.collection("usersFav").document(restaurantData.restaurantNames).setData(favoriteData) { error in
            if let error = error {
                print("Error adding favorite: \(error)")
            } else {
                isFavorite = true
            }
        }
    }

    // Removing data
    private func removeFromFavorites() {
        let db = Firestore.firestore()
        
        db.collection("usersFav").document(restaurantData.restaurantNames).delete() { error in
            if let error = error {
                print("Error removing favorite: \(error)")
            } else {
                isFavorite = false
            }
        }
    }
}

#Preview {
    RestaurantDetailsView(restaurantData: RestaurantData(restaurantNames: "The FarmHouse Garden", restaurantLocation: "location", restaurantDetails: "The details"))
}
