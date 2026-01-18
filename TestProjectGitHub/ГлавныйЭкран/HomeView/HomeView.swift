import SwiftUI

struct HomeView: View {

    @StateObject var vm = HomeViewModel()
    @State private var showAddCard = false

    var body: some View {
        VStack {
            HStack {
                Text("Список платежей")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
        
                Button {
                    showAddCard = true
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showAddCard) {
                    AddPaymentView(vm: vm)
                        .presentationDetents([.medium])
                }

            }
            .padding(.horizontal)
            
            ScrollView {
                VStack {
                    ForEach(vm.cards) { card in
                        PaymentCardView(vm: card)
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .padding(16)
        }
    }
}


struct PaymentCardView: View {
    let vm: PaymentCard

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.red)
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 6)


            VStack(alignment: .leading, spacing: 12) {

                HStack(spacing: 12) {
                    Circle()
                        .fill(Color.white.opacity(0.9))
                        .frame(width: 36, height: 36)
                        .overlay(
                            Image(systemName: "creditcard")
                                .foregroundColor(.red)
                        )

                    Text(vm.paymentName)
                        .font(.headline)

                    Spacer()
                }

                Text(vm.sum)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                HStack(spacing: 6) {
                    Image(systemName: "calendar")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))

                    Text(vm.paymentTerm)
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .padding()
        }
    }
}

struct AddPaymentView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: HomeViewModel

    @State private var name = ""
    @State private var sum = ""
    @State private var term = ""

    var body: some View {
        
        
        
        NavigationView {
            VStack {
                
                Text("")
                TextField("Название", text: $name)
                    .appTextField()
                HStack {
                    TextField("0.00", text: $sum)
                        .keyboardType(.numberPad)
                        .appTextField()
                    Text("валюта")
                }
                TextField("Срок", text: $term)
                    .appTextField()

            }
            .padding()
            .navigationTitle("Новый платёж")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        vm.saveCard(
                            name: name,
                            sum: sum,
                            term: term
                        )
                        dismiss()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
            }
        }
    }
}
