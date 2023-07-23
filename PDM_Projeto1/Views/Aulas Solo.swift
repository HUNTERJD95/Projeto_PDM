import SwiftUI

struct Aulas_Solo: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            NavigationLink(destination: Horarios_e_Marcacao_Aulas()) {
                Text("Yoga")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(Color.blue)
                    .cornerRadius(8)
            }

            NavigationLink(destination: Horarios_e_Marcacao_Aulas()) {
                Text("Musculação")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(Color.blue)
                    .cornerRadius(8)
            }

            NavigationLink(destination: Horarios_e_Marcacao_Aulas()) {
                Text("Natação")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(Color.blue)
                    .cornerRadius(8)
            }

            Spacer()
        }
        .navigationBarTitle("Aulas Individuais")
        .padding()
    }
}

struct Aulas_Solo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Aulas_Solo()
        }
    }
}
