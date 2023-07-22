import SwiftUI
import SQLite3

struct ModificarUser: View {
    @EnvironmentObject private var userControllerHolder: UserControllerHolder
    @State private var currentUsername = ""
    @State private var newUsername = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var isPasswordsMatchError = false
    @State private var isUsernameTakenError = false
    @State private var isUpdateSuccess = false
    @State private var isDeleteSuccess = false
    
    var body: some View {
        VStack {
            Text("Modificar Dados")
                .font(.largeTitle)
                .bold()
                .padding()
            
            // Current username display
            Text("Username Atual: \(currentUsername)")
                .foregroundColor(.black)
                .padding()
            
            TextField("Novo Username", text: $newUsername)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            
            SecureField("Nova Password", text: $newPassword)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            
            SecureField("Confirmar Nova Password", text: $confirmPassword)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            
            Button("Guardar Alterações") {
                modifyUser()
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.green)
            .cornerRadius(10)

            Button("Apagar Conta") {
                deleteUser()
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.red)
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
        .alert(isPresented: $isUpdateSuccess) {
            Alert(
                title: Text("Sucesso"),
                message: Text("Dados atualizados com sucesso!"),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert(isPresented: $isDeleteSuccess) {
            Alert(
                title: Text("Sucesso"),
                message: Text("Conta apagada com sucesso!"),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            // Set the currentUsername state variable with the current user's username
            if let currentUser = userControllerHolder.userController.currentUser {
                currentUsername = currentUser.username
            }
        }
    }

    func modifyUser() {
        if newPassword != confirmPassword {
            isPasswordsMatchError = true
            return
        }

        let userController = userControllerHolder.userController

        if userController.modifyUser(username: newUsername, password: newPassword) {
            isUpdateSuccess = true
            // If the username was updated successfully, update the currentUsername state variable
            currentUsername = newUsername
        } else {
            isUsernameTakenError = true
        }
    }

    func deleteUser() {
        let userController = userControllerHolder.userController

        if userController.deleteUser() {
            isDeleteSuccess = true
        }
    }
}

struct ModificarUser_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) var managedObjectContext
    static var previews: some View {
        // Create a dummy UserControllerHolder for the preview
        let userControllerHolder = UserControllerHolder()
        // Set any initial data you need for the preview
        // For example, you can set a dummy userController with some initial data
        userControllerHolder.userController.createUser(username: "dummyUser", password: "password123")

        return ModificarUser()
            .environmentObject(userControllerHolder)
    }
}
