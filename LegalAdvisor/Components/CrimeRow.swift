import SwiftUI

struct CrimeRow: View {
    let crime: Crime

    var body: some View {
        PressableCard {
            GlowingCard(color: crime.category.color) {
                HStack(spacing: 14) {
                    Circle()
                        .fill(crime.category.color.opacity(0.2))
                        .frame(width: 44, height: 44)
                        .overlay(
                            Image(systemName: crime.category.icon)
                                .font(.system(size: 18))
                                .foregroundColor(crime.category.color)
                        )

                    VStack(alignment: .leading, spacing: 4) {
                        Text(crime.name)
                            .font(Theme.Fonts.roundedHeadline())
                            .foregroundColor(.primary)
                            .lineLimit(1)

                        HStack(spacing: 8) {
                            Text(crime.formattedSection)
                                .font(Theme.Fonts.roundedCaption())
                                .foregroundColor(crime.category.color)

                            Text("•")
                                .foregroundColor(.secondary)

                            Text(crime.maximumSentence.formatted)
                                .font(Theme.Fonts.roundedCaption())
                                .foregroundColor(.secondary)
                        }
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
            }
        }
    }
}

#Preview {
    VStack {
        CrimeRow(crime: CrimeDatabase.shared.crimes.first!)
        CrimeRow(crime: CrimeDatabase.shared.crimes[5])
    }
    .padding()
    .background(Theme.Colors.background)
}
