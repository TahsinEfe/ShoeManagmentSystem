import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("sonarkaplan")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    
                    Spacer()
                    
                    
                    NavigationLink(destination: ListView()) {
                        HStack{
                            Image(systemName: "list.clipboard.fill")
                                .foregroundColor(.white)
                        Text("List")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(25)
                    }
                    .padding(.bottom, 20)
                    
                    NavigationLink(destination: AddView()) {
                        HStack{
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.white)
                        Text("Add")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .cornerRadius(25)
                    }
                    .padding(.bottom, 20)
                    
                    NavigationLink(destination: UpdateView()) {
                        HStack{
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                        Text("Update")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color.orange)
                            .cornerRadius(25)
                    }
                    .padding(.bottom, 20)
                    
                    NavigationLink(destination: DeleteView()) {
                        HStack {
                            Image(systemName: "trash.fill")
                                .foregroundColor(.white)
                            Text("Delete")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.red)
                        .cornerRadius(25)
                    }
                    .padding(.bottom, 50)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
