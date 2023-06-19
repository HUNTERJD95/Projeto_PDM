//
//  Login e Registo.swift
//  PDM_Projeto1
//
//  Created by user239318 on 6/19/23.
//

import SwiftUI



struct Login_e_Registo: View {
    var body: some View {
        LoginView()
    }
}

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Nome de Usuário", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Senha", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Login") {
                // Lógica para autenticar o usuário com base nos dados de login fornecidos
            }
            .padding()
            
            Button("Registrar") {
                // Lógica para registrar um novo usuário com base nos dados fornecidos
            }
            .padding()
        }
        .padding()
    }
}

struct Login_e_Registo_Previews: PreviewProvider {
    static var previews: some View {
        Login_e_Registo()
    }
}
