import SwiftUI
import UIKit

struct SpriteAnimationView: View {
    let imageName: String
    let columns: Int
    let rows: Int
    let frameCount: Int
    let frameDuration: Double

    @State private var currentFrame: Int = 0
    @State private var timer: Timer?
    @State private var frameImages: [UIImage] = []

    init(
        imageName: String = "RobotSprite",
        columns: Int = 5,
        rows: Int = 3,
        frameCount: Int = 15,
        frameDuration: Double = 0.5
    ) {
        self.imageName = imageName
        self.columns = columns
        self.rows = rows
        self.frameCount = frameCount
        self.frameDuration = frameDuration
    }

    var body: some View {
        Group {
            if !frameImages.isEmpty && currentFrame < frameImages.count {
                Image(uiImage: frameImages[currentFrame])
                    .resizable()
                    .interpolation(.high)
                    .aspectRatio(contentMode: .fit)
            } else {
                Color.clear
            }
        }
        .onAppear {
            loadFrames()
            startAnimation()
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
    }

    private func loadFrames() {
        guard let spriteSheet = UIImage(named: imageName),
              let cgImage = spriteSheet.cgImage else { return }

        let sheetWidth = CGFloat(cgImage.width)
        let sheetHeight = CGFloat(cgImage.height)
        let frameWidth = sheetWidth / CGFloat(columns)
        let frameHeight = sheetHeight / CGFloat(rows)

        var images: [UIImage] = []

        for i in 0..<frameCount {
            let col = i % columns
            let row = i / columns

            let rect = CGRect(
                x: CGFloat(col) * frameWidth,
                y: CGFloat(row) * frameHeight,
                width: frameWidth,
                height: frameHeight
            )

            if let croppedCGImage = cgImage.cropping(to: rect) {
                let frameImage = UIImage(cgImage: croppedCGImage)
                images.append(frameImage)
            }
        }

        frameImages = images
    }

    private func startAnimation() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { _ in
            currentFrame = (currentFrame + 1) % max(frameCount, 1)
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
            frameDuration: 0.4
        )
        .frame(width: 140, height: 120)
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
