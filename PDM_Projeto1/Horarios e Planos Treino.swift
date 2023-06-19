//
//  Horarios e Planos Treino.swift
//  PDM_Projeto1
//
//  Created by user239318 on 6/19/23.
//

import SwiftUI

struct Horarios_e_Planos_Treino: View {
    var body: some View {
        ScheduleView()
    }
}

struct ScheduleView: View {
    var body: some View {
        VStack {
            Text("Horários")
                .font(.title)
                .padding()
            
            List {
                // Exemplo de item de horário
                Text("Segunda-feira: 9:00 - 10:00")
                Text("Terça-feira: 14:00 - 15:00")
                Text("Quarta-feira: 18:00 - 19:00")
                // ...
            }
            
            Text("Plano de Treino")
                .font(.title)
                .padding()

            Text("Exercícios e descrição do plano de treino")
                .padding()
        }
    }
}

struct Horarios_e_Planos_Treino_Previews: PreviewProvider {
    static var previews: some View {
        Horarios_e_Planos_Treino()
    }
}
