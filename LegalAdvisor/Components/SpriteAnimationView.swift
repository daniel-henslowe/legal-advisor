import SwiftUI

struct SpriteAnimationView: View {
    let columns: Int
    let rows: Int
    let frameCount: Int
    let framesPerSecond: Double

    @State private var currentFrame: Int = 0

    private let timer: Timer.TimerPublisher
    private let spriteImage: Image

    init(
        imageName: String = "RobotSprite",
        columns: Int = 5,
        rows: Int = 3,
        frameCount: Int = 15,
        framesPerSecond: Double = 4
    ) {
        self.columns = columns
        self.rows = rows
        self.frameCount = frameCount
        self.framesPerSecond = framesPerSecond
        self.timer = Timer.publish(every: 1.0 / framesPerSecond, on: .main, in: .common)
        self.spriteImage = Image(imageName)
    }

    var body: some View {
        GeometryReader { geometry in
            let frameWidth = geometry.size.width
            let frameHeight = geometry.size.height

            spriteImage
                .resizable()
                .scaledToFill()
                .frame(
                    width: frameWidth * CGFloat(columns),
                    height: frameHeight * CGFloat(rows)
                )
                .offset(
                    x: -CGFloat(currentFrame % columns) * frameWidth,
                    y: -CGFloat(currentFrame / columns) * frameHeight
                )
        }
        .clipped()
        .onReceive(timer.autoconnect()) { _ in
            withAnimation(.none) {
                currentFrame = (currentFrame + 1) % frameCount
            }
        }
    }
}

struct RobotCharacterView: View {
    var body: some View {
        SpriteAnimationView(
            imageName: "RobotSprite",
            columns: 5,
            rows: 3,
            frameCount: 15,
            framesPerSecond: 3
        )
        .frame(width: 120, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    VStack {
        RobotCharacterView()
        Text("Legal Advisor")
            .font(.title)
    }
}
