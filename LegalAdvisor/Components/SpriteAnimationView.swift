import SwiftUI
import UIKit

struct RobotCharacterView: View {
    @State private var processedImage: UIImage?

    var body: some View {
        Group {
            if let image = processedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image("RobotSprite")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(width: 130, height: 130)
        .onAppear {
            processImage()
        }
    }

    private func processImage() {
        guard let originalImage = UIImage(named: "RobotSprite"),
              let cgImage = originalImage.cgImage else { return }

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
        ) else { return }

        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        guard let pixelBuffer = context.data else { return }

        let pixels = pixelBuffer.bindMemory(to: UInt8.self, capacity: width * height * bytesPerPixel)

        // Remove white/near-white background
        for y in 0..<height {
            for x in 0..<width {
                let offset = (y * width + x) * bytesPerPixel
                let r = pixels[offset]
                let g = pixels[offset + 1]
                let b = pixels[offset + 2]

                // Check if pixel is white or very light (background)
                let isLight = r >= 240 && g >= 240 && b >= 240

                if isLight {
                    pixels[offset + 3] = 0 // Make transparent
                }
            }
        }

        // Second pass: soften edges by checking neighbors
        for y in 1..<(height - 1) {
            for x in 1..<(width - 1) {
                let offset = (y * width + x) * bytesPerPixel
                let alpha = pixels[offset + 3]

                // If this pixel is opaque, check if it's on the edge of transparent area
                if alpha > 0 {
                    var transparentNeighbors = 0
                    for dy in -1...1 {
                        for dx in -1...1 {
                            let nOffset = ((y + dy) * width + (x + dx)) * bytesPerPixel
                            if pixels[nOffset + 3] == 0 {
                                transparentNeighbors += 1
                            }
                        }
                    }
                    // Soften edge pixels
                    if transparentNeighbors >= 3 {
                        let r = pixels[offset]
                        let g = pixels[offset + 1]
                        let b = pixels[offset + 2]
                        // If it's a light colored edge pixel, make it semi-transparent
                        if r >= 200 && g >= 200 && b >= 200 {
                            pixels[offset + 3] = UInt8(max(0, Int(alpha) - 100))
                        }
                    }
                }
            }
        }

        guard let outputCGImage = context.makeImage() else { return }
        processedImage = UIImage(cgImage: outputCGImage)
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
