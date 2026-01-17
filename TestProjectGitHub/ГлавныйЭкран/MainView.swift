import SwiftUI

struct MainView: View {

    @StateObject var vm = MainViewModel()

    var body: some View {
        VStack(spacing: 0) {


            ZStack {
                switch vm.selectedTab {
                case .home:
                    HomeView(vm: vm)
                case .favorites:
                    SignUpView()
                case .profile:
                    SignInView()
                }
            }

            Spacer()
            CustomTabBar(viewModel: vm)
        }
    }
}



struct HomeView: View {

    @ObservedObject var vm: MainViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Список платежей")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
        
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
            .padding(.horizontal)
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
            .frame(height: 150)
            .padding(16)
        }
    }
    
    
}

#Preview {
    MainView()
}



