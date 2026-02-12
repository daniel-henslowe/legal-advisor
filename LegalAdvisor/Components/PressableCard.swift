import SwiftUI

struct PressableCard<Content: View>: View {
    let content: Content

    @State private var isPressed = false

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        withAnimation(.easeInOut(duration: 0.1)) {
                            isPressed = true
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            isPressed = false
                        }
                    }
            )
    }
}

#Preview {
    PressableCard {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.blue)
            .frame(width: 150, height: 100)
    }
    .padding()
}
