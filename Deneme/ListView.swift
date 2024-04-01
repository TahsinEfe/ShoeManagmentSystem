import SwiftUI

struct ListView: View {
    @State private var shoes = [Shoe]()

    var body: some View {
        List(shoes) { shoe in
            ShoeListItemView(shoe: shoe)
                .padding(.vertical, 8)
        }
        .onAppear {
            fetchData()
        }
        .navigationTitle("Shoes")
    }

    func fetchData() {
        guard let url = URL(string: "https://shoesapi.intalalab.net/api/Shoe") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let shoeData = try decoder.decode([Shoe].self, from: data)
                    DispatchQueue.main.async {
                        self.shoes = shoeData
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

struct ShoeListItemView: View {
    let shoe: Shoe

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("ShoeId: \(shoe.id)")
                .font(.system(size: 14, weight: .regular))
            Text("Brand: \(shoe.brand)")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.gray)
            Text("Model: \(shoe.model)")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.gray)
            Text("Size: \(shoe.size)")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.gray)
            Text("Colour: \(shoe.colour)")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.gray)
            Text("Price: \(String(format: "%.0f", shoe.price))")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.gray)
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}


#Preview{
    ListView()
}
