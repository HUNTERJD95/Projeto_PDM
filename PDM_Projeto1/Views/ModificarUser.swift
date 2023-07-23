import SwiftUI

struct ModificarUser: View {
    @EnvironmentObject private var userControllerHolder: UserControllerHolder
    @Environment(\.presentationMode) var presentationMode
    
    var currentUser: User { userControllerHolder.userController.getUserFromLocalStorage() }
    
    @State private var newUsername = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var isPasswordsMatchError = false
    @State private var isUsernameTakenError = false
    @State private var isUpdateSuccess = false
    @State private var isDeleteSuccess = false
    @State private var shouldShowLoginView = false

    var body: some View {
        VStack {
            Text("Modificar")
                .font(.largeTitle)
                .bold()
                .padding()

            TextField("Novo Username", text: $newUsername)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .onChange(of: newUsername, perform: { value in
                    isUsernameTakenError = false
                })

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
                presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(isInvalidInput ? Color.gray : Color.green)
            .cornerRadius(10)
            .disabled(isInvalidInput)
            .padding(40)

            Button("Apagar Conta") {
                deleteUser()
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.red)
            .cornerRadius(10)
            .padding(50)
        
            Spacer()

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
                dismissButton: .default(Text("OK")) {
                    shouldShowLoginView = true // Set to true to show the Login view
                })
        }
        .fullScreenCover(isPresented: $shouldShowLoginView, content: {
            Login_e_Registo()
        })
        .onAppear {
            newUsername = currentUser.username
        }
    }

    private var isInvalidInput: Bool {
        newPassword != confirmPassword || newUsername.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func modifyUser() {
        if newPassword != confirmPassword {
            isPasswordsMatchError = true
            print("Wrong password")
            return
        }
        
        print("Updating user")

        let userController: UserController = userControllerHolder.userController

        // Modify the user with the new data
        if userController.updateUser(id: currentUser.id, newUsername: newUsername, newPassword: newPassword) {
            isUpdateSuccess = true
            userController.saveUserToLocalStorage(user: User(id: currentUser.id, username: newUsername, password: ""))
            print("User updated")
        } else {
            isUsernameTakenError = true
        }
    }
    
    func deleteUser() {
        let userController = userControllerHolder.userController

        // Delete the user
        if userController.deleteUser(id: currentUser.id) {
            isDeleteSuccess = true
            print("Deleted user with id \(currentUser.id)")
        } else {
            print("Failed to delete user with id \(currentUser.id)")
        }
    }
}

struct ModificarUser_Previews: PreviewProvider {
    static var previews: some View {
        let userControllerHolder = UserControllerHolder()
        return ModificarUser()
            .environmentObject(userControllerHolder)
    }
}
