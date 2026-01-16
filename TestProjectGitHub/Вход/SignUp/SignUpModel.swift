import Foundation

enum EmailValidationState: Equatable {
    case idle
    case valid
    case invalid(String)
}
enum SignUpResult: Equatable {
    case none
    case error(String)
    case success
}


struct LoginRequest: Codable {
    let email: String
    let password: String
}
