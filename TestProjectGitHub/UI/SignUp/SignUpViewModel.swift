import Foundation
import KeychainSwift
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

    func checkPassword() {
        guard passwordTextfield.count >= 8 else {
            signUpResult = .error("Пароль должен содержать минимум 8 символов")
            return
        }

        guard passwordTextfield.rangeOfCharacter(from: .letters) != nil else {
            signUpResult = .error("Пароль должен содержать хотя бы одну букву")
            return
        }

        guard passwordTextfield.rangeOfCharacter(from: .decimalDigits) != nil else {
            signUpResult = .error("Пароль должен содержать хотя бы одну цифру")
            return
        }

        let keychain = KeychainSwift()
        keychain.set(passwordTextfield,
                     forKey: "userPassword",
                     withAccess: .accessibleWhenUnlocked)

        signUpResult = .success
    }

    static func isValidEmail(_ email: String) -> Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: email)
    }

}
