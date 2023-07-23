import SwiftUI
import SQLite3
import Foundation

struct ModificarUser: View {
    @EnvironmentObject private var userControllerHolder: UserControllerHolder
    @Environment(\.presentationMode) var presentationMode
    
    var currentUser: User { UserControllerHolder().userController.getUserFromLocalStorage()
    }
    
    @State private var newUsername = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var isPasswordsMatchError = false
    @State private var isUsernameTakenError = false
    @State private var isUpdateSuccess = false
    @State private var isDeleteSuccess = false


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
                    isUsernameTakenError = false // Reset the error flag when the user starts typing a new username
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

            Button("Apagar Conta") {
                deleteUser()
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.red)
            .cornerRadius(10)

            Spacer()

            // Button("Voltar") {
            //     presentationMode.wrappedValue.dismiss()
            // }
            // .foregroundColor(.white)
            // .frame(width: 300, height: 50)
            // .background(Color.blue)
            // .cornerRadius(10)
            // .padding(.bottom, 20)
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
            print("Deleted user with id \(currentUser)")
        } else {
            // Handle the case when the userController fails to delete the user
        }
    }
}

struct ModificarUser_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy UserControllerHolder for the preview
        //let userControllerHolder = UserControllerHolder()
        // Set any initial data you need for the preview
        // For example, you can set a dummy userController with some initial data


        return ModificarUser()
            // .environmentObject(userControllerHolder)
    }
}
