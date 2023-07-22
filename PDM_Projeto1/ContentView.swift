import SwiftUI
import SQLite3

struct ContentView: View {
   

    @State private var isAuthenticated = true // For testing purposes, set to true

    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.ignoresSafeArea()

                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))

                VStack(spacing: 20) {
                    Text("Ginásio FIT")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    Text("Bem-Vindo!")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()

                    Spacer()

                    // Button to redirect to Aulas Solo view
                    NavigationLink(destination: Aulas_Solo()) {
                        Text("Aulas Solo")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }

                    // Button to redirect to Aulas Grupo view
                    NavigationLink(destination: Aulas_Grupo()) {
                        Text("Aulas Grupo")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .cornerRadius(10)
                    }

                    Spacer()

                   
                    NavigationLink(destination: Login_e_Registo()) {
                        Text("Logout")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 120, height: 60)
                            .background(Color.red)
                            .cornerRadius(10)
                    }

                    Button("Modificar/Apagar Conta") {
                        // Implement logic to modify or delete account here
                    }
                    .foregroundColor(.white)
                    .frame(width: 250, height: 60)
                    .background(Color.orange)
                    .cornerRadius(10)

                    Spacer()
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
