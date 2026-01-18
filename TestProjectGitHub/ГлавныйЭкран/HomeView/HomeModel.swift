import Foundation

struct PaymentCard: Identifiable {
    let id = UUID()
    let paymentName: String
    let sum: String
    let paymentTerm: String
}
