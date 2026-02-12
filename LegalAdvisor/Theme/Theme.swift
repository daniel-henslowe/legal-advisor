import SwiftUI

struct Theme {
    static let cornerRadius: CGFloat = 16
    static let cardPadding: CGFloat = 16

    struct Colors {
        static let background = Color(uiColor: .systemGroupedBackground)
        static let cardBackground = Color(uiColor: .secondarySystemGroupedBackground)

        static let violentCrime = Color(red: 0.9, green: 0.3, blue: 0.3)
        static let propertyCrime = Color(red: 0.3, green: 0.6, blue: 0.9)
        static let drugOffense = Color(red: 0.6, green: 0.4, blue: 0.8)
        static let financialCrime = Color(red: 0.3, green: 0.8, blue: 0.5)
        static let sexualOffense = Color(red: 0.9, green: 0.5, blue: 0.3)
        static let publicOrder = Color(red: 0.5, green: 0.7, blue: 0.9)
        static let trafficOffense = Color(red: 0.8, green: 0.7, blue: 0.3)
        static let cyberCrime = Color(red: 0.4, green: 0.8, blue: 0.8)
    }

    struct Fonts {
        static func roundedTitle() -> Font {
            .system(.title, design: .rounded, weight: .bold)
        }

        static func roundedTitle2() -> Font {
            .system(.title2, design: .rounded, weight: .bold)
        }

        static func roundedTitle3() -> Font {
            .system(.title3, design: .rounded, weight: .bold)
        }

        static func roundedHeadline() -> Font {
            .system(.headline, design: .rounded, weight: .semibold)
        }

        static func roundedBody() -> Font {
            .system(.body, design: .rounded, weight: .regular)
        }

        static func roundedSubheadline() -> Font {
            .system(.subheadline, design: .rounded, weight: .regular)
        }

        static func roundedCaption() -> Font {
            .system(.caption, design: .rounded, weight: .medium)
        }
    }
}

extension View {
    func glowEffect(color: Color, radius: CGFloat = 10) -> some View {
        self
            .shadow(color: color.opacity(0.5), radius: radius, x: 0, y: 0)
            .shadow(color: color.opacity(0.3), radius: radius * 2, x: 0, y: 0)
    }
}
