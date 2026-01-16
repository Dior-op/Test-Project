import Foundation
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? Color.blue.opacity(0.6) : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
    }
}

extension View {
    func primaryButton() -> some View {
        self.buttonStyle(PrimaryButtonStyle())
    }
}
