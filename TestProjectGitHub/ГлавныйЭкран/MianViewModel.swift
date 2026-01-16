import Foundation

final class MainViewModel: ObservableObject {
    
    @Published var paymentName: String = "Название платежа"
    @Published var sum: String = "$ 25 000"
    @Published var paymentTerm: String = "23 november"
    
    
}
