import SwiftUI

struct SpriteAnimationView: View {
    let columns: Int
    let rows: Int
    let frameCount: Int
    let frameDuration: Double

    @State private var currentFrame: Int = 0
    @State private var timer: Timer?

    private let spriteImage: Image

    init(
        imageName: String = "RobotSprite",
        columns: Int = 5,
        rows: Int = 3,
        frameCount: Int = 15,
        frameDuration: Double = 0.5
    ) {
        self.columns = columns
        self.rows = rows
        self.frameCount = frameCount
        self.frameDuration = frameDuration
        self.spriteImage = Image(imageName)
    }

    var body: some View {
        GeometryReader { geometry in
            let frameWidth = geometry.size.width
            let frameHeight = geometry.size.height
            let inset: CGFloat = 4

            spriteImage
                .resizable()
                .interpolation(.high)
                .frame(
                    width: (frameWidth + inset * 2) * CGFloat(columns),
                    height: (frameHeight + inset * 2) * CGFloat(rows)
                )
                .offset(
                    x: -CGFloat(currentFrame % columns) * (frameWidth + inset * 2) + inset,
                    y: -CGFloat(currentFrame / columns) * (frameHeight + inset * 2) + inset
                )
        }
        .clipped()
        .onAppear {
            startAnimation()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    private func startAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.15)) {
                currentFrame = (currentFrame + 1) % frameCount
            }
        }
    }
}

struct RobotCharacterView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            SpriteAnimationView(
                imageName: "RobotSprite",
                columns: 5,
                rows: 3,
                frameCount: 15,
                frameDuration: 0.6
            )
            .frame(width: 140, height: 110)

            // Gradient overlay to blend edges into background
            Rectangle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            .clear,
                            .clear,
                            Theme.Colors.background.opacity(0.3),
                            Theme.Colors.background
                        ]),
                        center: .center,
                        startRadius: 40,
                        endRadius: 80
                    )
                )
                .frame(width: 160, height: 130)
                .allowsHitTesting(false)
        }
    }
}

#Preview {
    VStack {
        RobotCharacterView()
        Text("Legal Advisor")
            .font(.title)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Theme.Colors.background)
}
