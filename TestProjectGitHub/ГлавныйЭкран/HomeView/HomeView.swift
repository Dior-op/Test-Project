//
//  HomeView.swift
//  TestProjectGitHub
//
//  Created by Shahriyor on 18/01/26.
//

import SwiftUI

struct HomeView: View {

    @StateObject var vm = HomeViewModel()

    var body: some View {
        VStack {
            HStack {
                Text("Список платежей")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
        
                Button {
                    vm.saveCard(
                        name: "Кредит",
                        sum: "15 000 ₽",
                        term: "До 20 сентября"
                    )

                } label: {
                    Image(systemName: "plus")
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
