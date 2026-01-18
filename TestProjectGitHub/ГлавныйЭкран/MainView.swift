import SwiftUI

struct MainView: View {

    @StateObject var vm = MainViewModel()

    var body: some View {
        VStack(spacing: 0) {


            ZStack {
                switch vm.selectedTab {
                case .home:
                    HomeView()
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




#Preview {
    MainView()
}



