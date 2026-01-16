import SwiftUI

struct SignUpView: View {
    
    @StateObject var vm = SignUpViewModel()
    private var isAlertPresented: Binding<Bool> {
        Binding(
            get: { vm.signUpResult != .none },
            set: { _ in vm.signUpResult = .none }
        )
    }



    var body: some View {
        
        VStack(spacing: 20) {
            
            Spacer()

            Text("AppName")
                .font(.system(size: 26, weight: .semibold))
                .foregroundColor(.primary)
            
            
            TextField("Name", text: $vm.nameTextfield)
                .appTextField()
            
            VStack(alignment: .leading, spacing: 4) {
                TextField("Email", text: $vm.emailTextfield)
                    .keyboardType(.emailAddress)
                    .appTextField()
                    .autocapitalization(.none)

                if case .invalid(let message) = vm.emailState {
                    Text(message)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }

            
            ZStack(alignment: .trailing) {
                if vm.isSecure {
                    SecureField("Password", text: $vm.passwordTextfield)
                        .appTextField()
                } else {
                    TextField("Password", text: $vm.passwordTextfield)
                        .appTextField()
                }

                Button(action: {
                    vm.isSecure.toggle()
                }) {
                    Image(systemName: vm.isSecure ? "eye.slash" : "eye")
                }
                .padding(.trailing, 10)
            }

            Button {
                guard vm.checkPassword() else { return }


                Task {
                    do {
                        try await vm.sendLogin(
                            email: vm.emailTextfield,
                            password: vm.passwordTextfield
                        )

                        await MainActor.run {
                            vm.signUpResult = .success
                        }

                    } catch {
                        await MainActor.run {
                            vm.signUpResult = .error("Ошибка сервера")
                        }
                    }
                }
            } label: {
                Text("Sign Up")
            }
            .primaryButton()
            
            .fullScreenCover(isPresented: $vm.isLoggedIn) {
                MainView()
                
            }
            
            .alert(isPresented: isAlertPresented) {
                switch vm.signUpResult {
                case .error(let message):
                    return Alert(
                        title: Text("Ошибка"),
                        message: Text(message),
                        dismissButton: .default(Text("OK"))
                    )

                case .success:
                    return Alert(
                        title: Text("Успешно"),
                        message: Text("Вы успешно зарегестрировались"),
                        dismissButton: .default(Text("OK")) {
                            vm.isLoggedIn = true
                        }
                    )

                case .none:
                    return Alert(title: Text(""))
                }
            }

            
            Spacer()

        }
        .onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil, from: nil, for: nil
            )
        }

        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [.purple, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing))

    }
    

}

#Preview {
    SignUpView()
}
