import SwiftUI

struct CategoryCard: View {
    let category: CrimeCategory

    var body: some View {
        PressableCard {
            GlowingCard(color: category.color) {
                VStack(spacing: 12) {
                    Image(systemName: category.icon)
                        .font(.system(size: 32))
                        .foregroundColor(category.color)
                        .glowEffect(color: category.color)

                    Text(category.rawValue)
                        .font(Theme.Fonts.roundedHeadline())
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)

                    Text("\(CrimeDatabase.shared.crimes(for: category).count) offenses")
                        .font(Theme.Fonts.roundedCaption())
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    HStack {
        CategoryCard(category: .violentCrimes)
        CategoryCard(category: .drugOffenses)
    }
    .padding()
    .background(Theme.Colors.background)
}
