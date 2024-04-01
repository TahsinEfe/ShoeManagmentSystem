import SwiftUI

struct UpdateView: View {
    @State private var shoeId = ""
    @State private var shoeBrand = ""
    @State private var shoeModel = ""
    @State private var shoeSize = ""
    @State private var shoeColour = ""
    @State private var shoePrice = ""
    @State private var showAlertSuccess = false
    @State private var showAlertError = false

    var body: some View {
        VStack {
            TextField("ShoeId", text: $shoeId)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

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
                updateShoe()
            }) {
                HStack {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                    Text("Update")
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .navigationTitle("Update Shoe")
        .alert(isPresented: $showAlertSuccess) {
            Alert(title: Text("Success"), message: Text("You have successfully updated the properties."), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $showAlertError) {
            Alert(title: Text("Error"), message: Text("The provided ShoeId is not in the list."), dismissButton: .default(Text("OK")))
        }
    }

    func updateShoe() {
        guard let shoeId = Int(shoeId),
              let shoeSize = Int(shoeSize),
              let shoePrice = Double(shoePrice) else {
           
            print("Invalid input data")
            return
        }

        let updatedShoe = Shoe(id: shoeId, brand: shoeBrand, model: shoeModel, size: shoeSize, colour: shoeColour, price: shoePrice)

    
        guard let jsonData = try? JSONEncoder().encode(updatedShoe) else {
            print("Error encoding updated shoe data")
            return
        }

     
        guard let url = URL(string: "https://shoesapi.intalalab.net/api/Shoe/\(shoeId)") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

     
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
            
                    print("Shoe updated successfully")
               
                    showAlertSuccess = true
                } else {
                 
                    print("Error: HTTP status code \(httpResponse.statusCode)")
                    
                    showAlertError = true
                }
            }
        }.resume()
    }
    
    func clearForm() {
        // Reset form fields
        shoeId = ""
        shoeBrand = ""
        shoeModel = ""
        shoeSize = ""
        shoeColour = ""
        shoePrice = ""
    }
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView()
    }
}
