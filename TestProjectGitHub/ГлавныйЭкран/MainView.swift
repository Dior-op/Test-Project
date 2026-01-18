import SwiftUI

struct MainView: View {

    @StateObject var vm = MainViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {

            Group {
                switch vm.selectedTab {
                case .home:
                    HomeView()
                case .favorites:
                    SignUpView()
                case .profile:
                    SignInView()
                }
            }
            .ignoresSafeArea(.keyboard) 

            CustomTabBar(viewModel: vm)
        }
    }
}


#Preview {
    MainView()
}



