import SwiftUI

struct AppTextFieldModifier: ViewModifier {
    @FocusState private var isFocused: Bool
    let hasError: Bool

    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 1.5)
            )
            .animation(.easeInOut(duration: 0.2), value: isFocused)
            .focused($isFocused)
    }

    private var borderColor: Color {
        if hasError {
            return .red
        } else if isFocused {
            return .blue
        } else {
            return .gray.opacity(0.4)
        }
    }
}


extension View {
    func appTextField(hasError: Bool = false) -> some View {
        self.modifier(AppTextFieldModifier(hasError: hasError))
    }
}
