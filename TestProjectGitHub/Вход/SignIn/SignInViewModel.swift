import Foundation

final class SignInViewModel: ObservableObject {
    
    @Published var passwordTextfield: String = ""
    @Published var isSecure = true
    
    @Published var email: String = ""
    @Published var message: String = ""
    @Published var isLoading = false
    @Published var isLoggedIn = false

    func login() async {
        guard let url = URL(string: "https://example.com/api/login") else {
            message = "Неверный URL"
            return
        }
        
        let loginData = LoginRequest(email: email, password: passwordTextfield)
        
        guard let jsonData = try? JSONEncoder().encode(loginData) else {
            message = "Ошибка кодирования"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        isLoading = true
        defer { isLoading = false }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                message = "Сервер вернул ошибку"
                return
            }
            
            let result = try JSONDecoder().decode(LoginResponse.self, from: data)
            message = result.message
            isLoggedIn = result.success
            
            if let token = result.token {
                UserDefaults.standard.set(token, forKey: "authToken")
            }
        } catch {
            message = "Ошибка сети: \(error.localizedDescription)"
        }
        
    }
    

    
}
