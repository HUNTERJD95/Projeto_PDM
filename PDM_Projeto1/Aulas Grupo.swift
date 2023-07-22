import SwiftUI

struct Aulas_Grupo: View {
    var body: some View {
        VStack {
            Spacer()
            
            NavigationLink(destination: Horarios_e_Marcacao_Aulas()) {
                Text("Pilates")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
            .buttonStyle(PrimaryButtonStyle())
            
            NavigationLink(destination: Horarios_e_Marcacao_Aulas()) {
                Text("Zumba")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
            .buttonStyle(PrimaryButtonStyle())
            
            NavigationLink(destination: Horarios_e_Marcacao_Aulas()) {
                Text("Body Pump")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
            .buttonStyle(PrimaryButtonStyle())
            
            Spacer()
        }
        .navigationBarTitle("Aulas de Grupo")
    }
}

struct PrimaryButtonStyleGrupo: ButtonStyle {
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

struct Aulas_Grupo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Aulas_Grupo()
        }
    }
}
