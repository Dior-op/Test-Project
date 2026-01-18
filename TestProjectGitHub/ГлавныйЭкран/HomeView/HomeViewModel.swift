import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published var cards: [PaymentCard] = [PaymentCard(paymentName: "скувше", sum: "$ 20 000", paymentTerm: "25 december")]
    
    func saveCard(name: String, sum: String, term: String) {
        let newCard = PaymentCard(paymentName: name, sum: sum, paymentTerm: term)
        cards.append(newCard)
        
    }
}



