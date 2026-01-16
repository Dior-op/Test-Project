import SwiftUI

struct SignInView: View {
    
    @StateObject var vm = SignInViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                
                Text("AppName")
                    .font(.title)
                
                TextField("email", text: $vm.email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .appTextField()
                
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
                    Task {
                        await vm.login()
                    }
                } label: {
                    Text("Contune")
                }
                .primaryButton()
                
                Text(vm.message)
                    .foregroundColor(vm.isLoggedIn ? .green : .red)
                    .padding()
            }
            
            .padding()
            if vm.isLoading {
                ProgressView()
            }

        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red.opacity(0.4))
        
    }
}

#Preview {
    SignInView()
}
