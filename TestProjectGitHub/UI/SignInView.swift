import SwiftUI

struct SignInView: View {
    
    
    @State var emailTextfield: String = ""
    var body: some View {
        ZStack {
            VStack {
                
                Text("Sign In")
                
                TextField("email", text: $emailTextfield)
                    .keyboardType(.emailAddress)
                    .appTextField()

            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red.opacity(0.4))
        
    }
}

#Preview {
    SignInView()
}
