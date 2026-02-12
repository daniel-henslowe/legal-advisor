import SwiftUI
import UIKit

struct RobotCharacterView: View {
    @State private var robotImage: UIImage?

    var body: some View {
        Group {
            if let image = robotImage {
                Image(uiImage: image)
                    .resizable()
                    .interpolation(.high)
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "scale.3d")
                    .font(.system(size: 48))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
        }
        .frame(width: 130, height: 110)
        .onAppear {
            loadFirstFrame()
        }
    }

    private func loadFirstFrame() {
        guard let spriteSheet = UIImage(named: "RobotSprite"),
              let cgImage = spriteSheet.cgImage else { return }

        let columns = 5
        let rows = 3
        let sheetWidth = CGFloat(cgImage.width)
        let sheetHeight = CGFloat(cgImage.height)
        let frameWidth = sheetWidth / CGFloat(columns)
        let frameHeight = sheetHeight / CGFloat(rows)

        // Get the first frame (top-left)
        let rect = CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight)

        if let croppedCGImage = cgImage.cropping(to: rect) {
            let frameImage = UIImage(cgImage: croppedCGImage)
            robotImage = removeCheckeredBackground(from: frameImage)
        }
    }

    private func removeCheckeredBackground(from image: UIImage) -> UIImage? {
        guard let cgImage = image.cgImage else { return image }

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
        ) else { return image }

        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        guard let pixelBuffer = context.data else { return image }

        let pixels = pixelBuffer.bindMemory(to: UInt8.self, capacity: width * height * bytesPerPixel)

        for y in 0..<height {
            for x in 0..<width {
                let offset = (y * width + x) * bytesPerPixel
                let r = pixels[offset]
                let g = pixels[offset + 1]
                let b = pixels[offset + 2]

                // Detect checkered pattern - grey (~192-210) and white/light (~240-255)
                let isGrey = (r >= 185 && r <= 215) && (g >= 185 && g <= 215) && (b >= 185 && b <= 215)
                let isWhite = r >= 240 && g >= 240 && b >= 240

                if isGrey || isWhite {
                    pixels[offset + 3] = 0 // Make transparent
                }
            }
        }

        guard let outputCGImage = context.makeImage() else { return image }
        return UIImage(cgImage: outputCGImage)
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
