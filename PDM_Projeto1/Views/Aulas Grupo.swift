import SwiftUI

struct Aulas_Grupo: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            NavigationLink(destination: Horarios_e_Marcacao_Aulas()) {
                Text("Pilates")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(Color.blue)
                    .cornerRadius(8)
            }

            NavigationLink(destination: Horarios_e_Marcacao_Aulas()) {
                Text("Zumba")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(Color.blue)
                    .cornerRadius(8)
            }

            NavigationLink(destination: Horarios_e_Marcacao_Aulas()) {
                Text("Body Pump")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(Color.blue)
                    .cornerRadius(8)
            }

            Spacer()
        }
        .navigationBarTitle("Aulas de Grupo")
        .padding()
    }
}

struct Aulas_Grupo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Aulas_Grupo()
        }
    }
}
