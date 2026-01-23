//
//  AppHubUI.swift
//  TestProjectGitHub
//
//  Created by Shahriyor on 23/01/26.
//

import SwiftUI

struct AppHubUI: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            
            ProgressView()
                .padding(24)
                .background(.ultraThinMaterial)
                .cornerRadius(12)
        }
    }
}

#Preview {
    AppHubUI()
}
