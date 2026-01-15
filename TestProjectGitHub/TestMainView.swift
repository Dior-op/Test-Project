import SwiftUI

struct TestMainView: View {
    
    @State var text: String = "hello word"
    @State private var showSheetSignIn: Bool = false
    @State private var showSheetSignUp: Bool = false

    var body: some View {
        VStack() {
            Text(text)

            
            VStack {
            
                Button {
                    showSheetSignIn = true
                } label: {
                    Text("Sign Up")
                }
                .primaryButton()
                .sheet(isPresented: $showSheetSignIn) {
                    SignUpView()
                }

                Button {
                    showSheetSignUp = true
                } label: {
                    Text("Sign In")
                }
                .primaryButton()
                .sheet(isPresented: $showSheetSignUp) {
                    SignInView()
                }

            }
            .padding()
        }
    }
}


#Preview {
    TestMainView()
}
