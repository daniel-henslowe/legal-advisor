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
                if let processedImage = removeCheckeredBackground(from: frameImage) {
                    images.append(processedImage)
                } else {
                    images.append(frameImage)
                }
            }
        }

        frameImages = images
    }

    private func removeCheckeredBackground(from image: UIImage) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }

        let width = cgImage.width
        let height = cgImage.height
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8

        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else { return nil }

        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        guard let pixelBuffer = context.data else { return nil }

        let pixels = pixelBuffer.bindMemory(to: UInt8.self, capacity: width * height * bytesPerPixel)

        for y in 0..<height {
            for x in 0..<width {
                let offset = (y * width + x) * bytesPerPixel
                let r = pixels[offset]
                let g = pixels[offset + 1]
                let b = pixels[offset + 2]

                // Detect checkered pattern colors (light grey ~204 and white ~255)
                // Also catch slightly off colors due to compression
                let isLightGrey = (r >= 195 && r <= 215) && (g >= 195 && g <= 215) && (b >= 195 && b <= 215)
                let isWhite = (r >= 245 && r <= 255) && (g >= 245 && g <= 255) && (b >= 245 && b <= 255)
                let isNearWhite = (r >= 235 && r <= 255) && (g >= 235 && g <= 255) && (b >= 235 && b <= 255)

                // Check if this pixel is part of the checkered background
                if isLightGrey || isWhite || isNearWhite {
                    // Check surrounding pixels to make sure we're not removing part of the character
                    // If surrounded by similar colors, it's likely background
                    var similarNeighbors = 0
                    let checkRadius = 2

                    for dy in -checkRadius...checkRadius {
                        for dx in -checkRadius...checkRadius {
                            let nx = x + dx
                            let ny = y + dy
                            if nx >= 0 && nx < width && ny >= 0 && ny < height {
                                let nOffset = (ny * width + nx) * bytesPerPixel
                                let nr = pixels[nOffset]
                                let ng = pixels[nOffset + 1]
                                let nb = pixels[nOffset + 2]

                                let nIsLight = (nr >= 190 && ng >= 190 && nb >= 190)
                                if nIsLight {
                                    similarNeighbors += 1
                                }
                            }
                        }
                    }

                    // If most neighbors are also light, this is likely background
                    let totalChecked = (checkRadius * 2 + 1) * (checkRadius * 2 + 1)
                    if similarNeighbors > totalChecked / 2 {
                        pixels[offset + 3] = 0 // Set alpha to 0 (transparent)
                    }
                }
            }
        }

        guard let outputCGImage = context.makeImage() else { return nil }
        return UIImage(cgImage: outputCGImage)
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
            frameDuration: 0.35
        )
        .frame(width: 150, height: 130)
        .frame(maxWidth: .infinity)
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
