//
//  CustomTabBar.swift
//  TestProjectGitHub
//
//  Created by Shahriyor on 17/01/26.
//

import SwiftUI

struct CustomTabBar: View {
    
    let tabs: [TabBarItem] = [
        TabBarItem(title: "home", iconNmae: "house", color: .red),
        TabBarItem(title: "ps", iconNmae: "playstation.logo", color: .green),
        TabBarItem(title: "setings", iconNmae: "person", color: .orange)
    ]
    
    @State var selection: TabBarItem = TabBarItem(title: "setings", iconNmae: "person", color: .orange)

    var body: some View {
        Spacer()
        HStack {
            ForEach(tabs, id: \.self) { tab in
                VStack {
                    Image(systemName: tab.iconNmae)
                        .font(.subheadline)
                    Text(tab.title)
                        
                }
                .onTapGesture {
                    switchToTab(tab: tab)
                }
                .foregroundColor(selection == tab ? tab.color : Color.gray)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(selection == tab ? tab.color.opacity(0.2) : Color.clear)
                .cornerRadius(10)

            }
        }
        .padding()
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        

        
    }
    private func switchToTab(tab: TabBarItem) {
        withAnimation(.easeInOut) {
            selection = tab
        }
    }
}

#Preview {
    CustomTabBar()
}



struct TabBarItem: Hashable {
    
    let title: String
    let iconNmae: String
    let color: Color
}
