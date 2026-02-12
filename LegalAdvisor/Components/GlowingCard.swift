import SwiftUI

struct GlowingCard<Content: View>: View {
    let color: Color
    let content: Content

    init(color: Color, @ViewBuilder content: () -> Content) {
        self.color = color
        self.content = content()
    }

    var body: some View {
        content
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: Theme.cornerRadius)
                        .fill(Theme.Colors.cardBackground)

                    RoundedRectangle(cornerRadius: Theme.cornerRadius)
                        .fill(
                            LinearGradient(
                                colors: [
                                    color.opacity(0.08),
                                    color.opacity(0.02),
                                    .clear
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )

                    RoundedRectangle(cornerRadius: Theme.cornerRadius)
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    color.opacity(0.3),
                                    color.opacity(0.1),
                                    .clear
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
            )
            .shadow(color: color.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    VStack(spacing: 20) {
        GlowingCard(color: .purple) {
            Text("Purple Glow")
                .padding()
        }

        GlowingCard(color: .blue) {
            Text("Blue Glow")
                .padding()
        }

        GlowingCard(color: .red) {
            Text("Red Glow")
                .padding()
        }
    }
    .padding()
    .background(Theme.Colors.background)
}
