import SwiftUI

struct Aulas_Solo: View {
    var body: some View {
        VStack {
            Spacer()
            
            NavigationLink(destination: Horarios_e_Marcacao_Aulas()) {
                Text("Yoga")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
            .buttonStyle(PrimaryButtonStyle())
            
            NavigationLink(destination: Horarios_e_Marcacao_Aulas()) {
                Text("Musculação")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
            .buttonStyle(PrimaryButtonStyle())
            
            NavigationLink(destination: Horarios_e_Marcacao_Aulas()) {
                Text("Natação")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
            .buttonStyle(PrimaryButtonStyle())
            
            Spacer()
        }
        .navigationBarTitle("Aulas Individuais")
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct Aulas_Solo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Aulas_Solo()
        }
    }
}
