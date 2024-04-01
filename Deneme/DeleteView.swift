import SwiftUI

struct DeleteView: View {
    @State private var shoeId = ""
    @State private var showAlertSuccess = false
    @State private var showAlertNotFound = false

    var body: some View {
        VStack {
            TextField("Enter ShoeId", text: $shoeId)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                deleteShoe()
            }) {
                HStack {
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                    Text("Delete")
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .navigationTitle("Delete Shoe")
        .alert(isPresented: $showAlertSuccess) {
            Alert(title: Text("Success"), message: Text("You have successfully deleted the item."), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $showAlertNotFound) {
            Alert(title: Text("Not Found"), message: Text("No value with this ID was found."), dismissButton: .default(Text("OK")))
        }
    }

    func deleteShoe() {
        guard let shoeId = Int(shoeId) else {
            print("Invalid shoe ID")
            return
        }

        guard let url = URL(string: "https://shoesapi.intalalab.net/api/Shoe/\(shoeId)") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { // Ensure UI updates happen on the main thread
                if let error = error {
                    print("Error: \(error)")
                } else if let httpResponse = response as? HTTPURLResponse {
                    if (200...299).contains(httpResponse.statusCode) {
                        print("Shoe deleted successfully")
                        showAlertSuccess = true // Show success alert
                    } else if httpResponse.statusCode == 404 {
                        print("No value with this ID was found")
                        showAlertNotFound = true // Show not found alert
                    } else {
                        print("Error: HTTP status code \(httpResponse.statusCode)")
                    }
                }
            }
        }.resume()
    }
}

struct DeleteView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteView()
    }
}
