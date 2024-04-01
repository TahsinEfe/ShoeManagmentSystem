import SwiftUI

struct AddView: View {
    @State private var shoeBrand = ""
    @State private var shoeModel = ""
    @State private var shoeSize = ""
    @State private var shoeColour = ""
    @State private var shoePrice = ""
    
    @State private var showAlert = false

    var body: some View {
        VStack {
            TextField("ShoeBrand", text: $shoeBrand)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("ShoeModel", text: $shoeModel)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("ShoeSize", text: $shoeSize)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("ShoeColour", text: $shoeColour)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("ShoePrice", text: $shoePrice)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                addShoe()
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.white)
                    Text("Add")
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .navigationTitle("Add Shoe")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success"), message: Text("You have successfully added the item."), dismissButton: .default(Text("OK")))
        }
    }

    func addShoe() {
        guard let shoeSize = Int(shoeSize),
              let shoePrice = Double(shoePrice) else {
      
            print("Invalid input data")
            return
        }

   
        let shoeData: [String: Any] = [
            "ShoeBrand": shoeBrand,
            "ShoeModel": shoeModel,
            "ShoeSize":  shoeSize,
            "ShoeColour": shoeColour,
            "ShoePrice": shoePrice
        ]


        guard let jsonData = try? JSONSerialization.data(withJSONObject: shoeData) else {
            print("Error converting data to JSON")
            return
        }

        
        guard let url = URL(string: "https://shoesapi.intalalab.net/api/Shoe") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

     
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                if let httpResponse = response as? HTTPURLResponse {
                    if (200...299).contains(httpResponse.statusCode) {
                       
                        print("New shoe added successfully")
                        
                 
                        showAlert = true
                        
                    
                        DispatchQueue.main.async {
                            self.shoeBrand = ""
                            self.shoeModel = ""
                            self.shoeSize = ""
                            self.shoeColour = ""
                            self.shoePrice = ""
                        }
                    } else {
                        
                        print("Error: HTTP status code \(httpResponse.statusCode)")
                    }
                }
            }
        }.resume()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
