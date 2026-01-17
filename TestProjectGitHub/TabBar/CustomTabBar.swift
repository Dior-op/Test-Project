import SwiftUI

struct CustomTabBar: View {

    @ObservedObject var viewModel: MainViewModel
    @Namespace private var animation

    var body: some View {
        
        HStack(spacing: 0) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                tabItem(tab)
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 6)
        )
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
    }

    private func tabItem(_ tab: TabItem) -> some View {
        Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                viewModel.selectedTab = tab
            }
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            VStack(spacing: 6) {
                ZStack {
                    if viewModel.selectedTab == tab {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.red.opacity(0.2))
                            .matchedGeometryEffect(id: "tab_background", in: animation)
                            .frame(width: 44, height: 32)
                    }

                    Image(systemName: tab.icon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(
                            viewModel.selectedTab == tab ? .red : .gray
                        )
                }

                Text(tab.title)
                    .font(.caption2)
                    .foregroundColor(
                        viewModel.selectedTab == tab ? .red : .gray
                    )
            }
            .frame(maxWidth: .infinity)
        }
    }
}
