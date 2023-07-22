//  Login e Registo.swift
//  PDM_Projeto1
//
//  Created by user239318 on 6/19/23.
//
import SwiftUI

struct Login_e_Registo: View {
    
    @StateObject private var userControllerHolder = UserControllerHolder()
    
    var body: some View {
        LoginView()
            .environmentObject(userControllerHolder)
    }
}

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var showingRegistrationScreen = false
    
    @EnvironmentObject private var userControllerHolder: UserControllerHolder
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showAlert = false
    @State private var isLoginSuccess = false // New state variable for login success
    
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
                
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(Color.red, width: wrongUsername != 0 ? 1 : 0)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(Color.red, width: wrongPassword != 0 ? 1 : 0)
                    
                    Button("Login") {
                        autenticarUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Login Falhou!"),
                            message: Text("Credenciais Inválidas. Tente novamente."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    Button("Registar") {
                        showingRegistrationScreen = true
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingRegistrationScreen) {
                RegistrationView()
                    .environment(\.managedObjectContext, viewContext)
            }
            .fullScreenCover(isPresented: $isLoginSuccess) {
                ContentView()
            }
        }
    }
    
    func autenticarUser(username: String, password: String) {
        // Validate the user login here
        let userController = userControllerHolder.userController
        
        if let user = userController.getUser(username: username, password: password) {
            // Login successful
            print("Login successful for user: \(user.username)")
            isLoginSuccess = true // Set to true to navigate to ContentView
        } else {
            // Login failed
            print("Invalid credentials. Please try again.")
            wrongUsername = 1 // Indicate incorrect credentials for UI feedback
            wrongPassword = 1
        }
    }
}



struct RegistrationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var userControllerHolder: UserControllerHolder // Access the UserControllerHolder
    
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var isPasswordsMatchError = false
    @State private var isUsernameTakenError = false
    @State private var isRegistrationSuccess = false

    var body: some View {
        VStack {
            Text("Registo")
                .font(.largeTitle)
                .bold()
                .padding()
            
            TextField("Username", text: $username)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            
            SecureField("Password", text: $password)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            
            SecureField("Confirmar Password", text: $confirmPassword)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            
            Button("Registar") {
                registerUser()
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.green)
            .cornerRadius(10)

            Button("Voltar") {
                presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
        }
        .padding()
        .alert(isPresented: $isPasswordsMatchError) {
            Alert(
                title: Text("Erro"),
                message: Text("As senhas não coincidem. Por favor, tente novamente."),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert(isPresented: $isUsernameTakenError) {
            Alert(
                title: Text("Erro"),
                message: Text("O nome de usuário já está em uso. Por favor, escolha outro."),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert(isPresented: $isRegistrationSuccess) {
            Alert(
                title: Text("Sucesso"),
                message: Text("Registo concluído com sucesso!"),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    func registerUser() {
        if password != confirmPassword {
            isPasswordsMatchError = true
            return
        }

        let userController = userControllerHolder.userController

        if userController.createUser(username: username, password: password) {
            isRegistrationSuccess = true
            presentationMode.wrappedValue.dismiss()
        } else {
            isUsernameTakenError = true
        }
    }
}

struct Login_e_Registo_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) var managedObjectContext
    static var previews: some View {

        // let dataController = DataController() // Cria uma instância de DataController
        //let context = dataController.container.viewContext // Obtém o contexto do container
        let userControllerHolder = UserControllerHolder()
        return Login_e_Registo()
            .environmentObject(userControllerHolder)
            //.environment(\.managedObjectContext, context)
            //.environmentObject(dataController) // Adiciona o dataController como um environment object
    }
}
