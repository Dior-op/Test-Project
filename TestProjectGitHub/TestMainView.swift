//
//  TestMainView.swift
//  TestProjectGitHub
//
//  Created by Shahriyor on 15/01/26.
//

import SwiftUI

struct TestMainView: View {
    @State var text: String = "hello word"
    var body: some View {
        Text(text)
    }
}

#Preview {
    TestMainView()
}
