import SwiftUI

struct DisclaimerView: View {
    @Binding var hasAcceptedDisclaimer: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 48))
                    .foregroundColor(.orange)
                    .glowEffect(color: .orange)

                Text("Important Legal Disclaimer")
                    .font(Theme.Fonts.roundedTitle2())
                    .foregroundColor(.primary)

                VStack(alignment: .leading, spacing: 16) {
                    disclaimerPoint(
                        icon: "info.circle.fill",
                        text: "This app provides general information about Canadian criminal law for educational purposes only."
                    )

                    disclaimerPoint(
                        icon: "person.fill.questionmark",
                        text: "This information does NOT constitute legal advice. Always consult a qualified lawyer for legal matters."
                    )

                    disclaimerPoint(
                        icon: "clock.fill",
                        text: "Laws change frequently. While we strive for accuracy, information may be outdated or incomplete."
                    )

                    disclaimerPoint(
                        icon: "scalemass.fill",
                        text: "Actual sentences depend on many factors including circumstances, prior record, and judicial discretion."
                    )

                    disclaimerPoint(
                        icon: "mappin.circle.fill",
                        text: "Provincial variations and local practices may affect how laws are applied in your jurisdiction."
                    )
                }
                .padding(.horizontal)

                VStack(spacing: 8) {
                    Text("Data Version: \(CrimeDatabase.shared.dataVersion)")
                        .font(Theme.Fonts.roundedCaption())
                        .foregroundColor(.secondary)

                    Text("Last Updated: \(CrimeDatabase.shared.lastUpdated)")
                        .font(Theme.Fonts.roundedCaption())
                        .foregroundColor(.secondary)
                }

                Button {
                    withAnimation(.spring(response: 0.3)) {
                        hasAcceptedDisclaimer = true
                    }
                } label: {
                    Text("I Understand")
                        .font(Theme.Fonts.roundedHeadline())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(14)
                }
                .padding(.horizontal)
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Theme.Colors.cardBackground)
            )
            .padding(24)
        }
    }

    private func disclaimerPoint(icon: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.blue)
                .frame(width: 24)

            Text(text)
                .font(Theme.Fonts.roundedSubheadline())
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    DisclaimerView(hasAcceptedDisclaimer: .constant(false))
}
