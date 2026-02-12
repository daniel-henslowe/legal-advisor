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

        // Remove white/near-white/light grey background - very aggressive threshold
        for y in 0..<height {
            for x in 0..<width {
                let offset = (y * width + x) * bytesPerPixel
                let r = pixels[offset]
                let g = pixels[offset + 1]
                let b = pixels[offset + 2]

                // Very aggressive: remove anything that looks like background
                // Check if pixel is light (background) or near-white
                let isLight = r >= 180 && g >= 180 && b >= 180

                // Also check if it's a grey tone (R≈G≈B)
                let maxChannel = max(r, max(g, b))
                let minChannel = min(r, min(g, b))
                let isGrey = (maxChannel - minChannel) < 30 && r >= 150

                if isLight || isGrey {
                    pixels[offset + 3] = 0 // Make transparent
                }
            }
        }

        // Third pass: flood fill from corners to remove any remaining background
        // Check corners - they should be background
        let cornerPositions = [
            (0, 0), (width - 1, 0), (0, height - 1), (width - 1, height - 1),
            (width / 2, 0), (0, height / 2), (width - 1, height / 2), (width / 2, height - 1)
        ]

        for (startX, startY) in cornerPositions {
            let offset = (startY * width + startX) * bytesPerPixel
            let r = pixels[offset]
            let g = pixels[offset + 1]
            let b = pixels[offset + 2]
            // If corner pixel is light-ish, make it transparent
            if r >= 150 && g >= 150 && b >= 150 {
                pixels[offset + 3] = 0
            }
        }

        // Second pass: remove light pixels that border transparent pixels
        for y in 1..<(height - 1) {
            for x in 1..<(width - 1) {
                let offset = (y * width + x) * bytesPerPixel
                let alpha = pixels[offset + 3]
                let r = pixels[offset]
                let g = pixels[offset + 1]
                let b = pixels[offset + 2]

                // If this pixel is opaque and light-ish
                if alpha > 0 && r >= 160 && g >= 160 && b >= 160 {
                    var transparentNeighbors = 0
                    for dy in -1...1 {
                        for dx in -1...1 {
                            let nOffset = ((y + dy) * width + (x + dx)) * bytesPerPixel
                            if pixels[nOffset + 3] == 0 {
                                transparentNeighbors += 1
                            }
                        }
                    }
                    // If touching transparent area, make this transparent too
                    if transparentNeighbors >= 2 {
                        pixels[offset + 3] = 0
                    }
                }
            }
        }

        // Run edge cleanup multiple times to erode the border - more passes
        for _ in 0..<8 {
            for y in 1..<(height - 1) {
                for x in 1..<(width - 1) {
                    let offset = (y * width + x) * bytesPerPixel
                    let alpha = pixels[offset + 3]
                    let r = pixels[offset]
                    let g = pixels[offset + 1]
                    let b = pixels[offset + 2]

                    // More aggressive threshold for erosion
                    if alpha > 0 && r >= 140 && g >= 140 && b >= 140 {
                        var transparentNeighbors = 0
                        for dy in -1...1 {
                            for dx in -1...1 {
                                let nOffset = ((y + dy) * width + (x + dx)) * bytesPerPixel
                                if pixels[nOffset + 3] == 0 {
                                    transparentNeighbors += 1
                                }
                            }
                        }
                        if transparentNeighbors >= 1 {
                            pixels[offset + 3] = 0
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
