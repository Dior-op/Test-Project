import Foundation
import Combine

final class SignUpViewModel: ObservableObject {

    @Published var nameTextfield: String = ""
    @Published var emailTextfield: String = ""
    @Published var passwordTextfield = ""
    @Published var isSecure = true

    @Published var emailState: EmailValidationState = .idle
    @Published var signUpResult: SignUpResult = .none
    @Published var isLoggedIn: Bool = false

    private var cancellables = Set<AnyCancellable>()

    
    init() {
        $emailTextfield
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { email in
                if email.isEmpty {
                    return .idle
                } else if Self.isValidEmail(email) {
                    return .valid
                } else {
                    return .invalid("Некорректный email")
                }
            }
            .assign(to: &$emailState)
    }

    func checkPassword() -> Bool {
        guard passwordTextfield.count >= 8 else {
            signUpResult = .error("Пароль должен содержать минимум 8 символов")
            return false
        }

        guard passwordTextfield.rangeOfCharacter(from: .letters) != nil else {
            signUpResult = .error("Пароль должен содержать хотя бы одну букву")
            return false
        }

        guard passwordTextfield.rangeOfCharacter(from: .decimalDigits) != nil else {
            signUpResult = .error("Пароль должен содержать хотя бы одну цифру")
            return false
        }

        signUpResult = .success
        return true
    }

    static func isValidEmail(_ email: String) -> Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: email)
    }

    
    func sendLogin(email: String, password: String) async throws {
        guard let url = URL(string: "") else {
            throw URLError(.badURL)
        }
        let body = LoginRequest(email: email, password: password)
        let jsonData = try JSONEncoder().encode(body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}
