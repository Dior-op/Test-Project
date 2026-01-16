import Foundation

struct User: Identifiable {
    let id: Int
    let email: String
    let password: String
}

let mockUsers: [User] = [
    User(id: 1, email: "test@example.com", password: "123456"),
    User(id: 2, email: "admin@example.com", password: "admin123"),
    User(id: 3, email: "user@example.com", password: "qwerty"),
    User(id: 4, email: "1", password: "1")

]


struct LoginResponse: Codable {
    let success: Bool
    let message: String
    let token: String?
}
