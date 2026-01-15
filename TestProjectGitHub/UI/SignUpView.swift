import SwiftUI
import KeychainSwift

struct SignUpView: View {
    
    @State var nameTextfield: String = ""
    @State var fullnameTextfield: String = ""
    
    @State private var passwordTextfield = ""
    @State private var isSecure = true
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var isLoggedIn = false


    var body: some View {
        
        VStack(spacing: 20) {
            
            Spacer()

            Text("AppName")
                .font(.system(size: 26, weight: .semibold))
                .foregroundColor(.primary)
            
            
            TextField("Name", text: $nameTextfield)
                .appTextField()
            
            TextField("Fullname", text: $fullnameTextfield)
                .appTextField()
            
            
            ZStack(alignment: .trailing) {
                if isSecure {
                    SecureField("Password", text: $passwordTextfield)
                        .appTextField()
                } else {
                    TextField("Password", text: $passwordTextfield)
                        .appTextField()
                }

                Button(action: {
                    isSecure.toggle()
                }) {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                }
                .padding(.trailing, 10)
            }


            
            Button {
                CheckPassword(passwordTextfield)
            } label: {
                Text("Sign Up")
            }
            .primaryButton()
            
            .fullScreenCover(isPresented: $isLoggedIn) {
                MainView()
                
            }
            
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Внимание"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        if alertMessage == "Пароль принят" {
                            isLoggedIn = true
                        }
                    }
                )
            }

            Spacer()

        }
        
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .background(Color.purple.opacity(0.4))

    }
    
    
    func CheckPassword(_ password: String) {
        // Проверка длины
        guard password.count >= 8 else {
            alertMessage = "Пароль должен содержать минимум 8 символов"
            showAlert = true
            return
        }

        // Проверка наличия буквы
        let hasLetter = password.rangeOfCharacter(from: .letters) != nil
        guard hasLetter else {
            alertMessage = "Пароль должен содержать хотя бы одну букву"
            showAlert = true
            return
        }
        
        // Проверка наличия цифры
        let hasNumber = password.rangeOfCharacter(from: .decimalDigits) != nil
        guard hasNumber else {
            alertMessage = "Пароль должен содержать хотя бы одну цифру"
            showAlert = true
            return
        }

        // Если всё ок
        let keychain = KeychainSwift()
        keychain.set(password, forKey: "userPassword", withAccess: .accessibleWhenUnlocked)

        alertMessage = "Пароль принят"
        showAlert = true
    }
}

#Preview {
    SignUpView()
}
