import SwiftUI

struct JurisdictionPicker: View {
    @Binding var selection: Jurisdiction

    var body: some View {
        GlowingCard(color: .blue) {
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 20))
                    .foregroundColor(.blue)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Jurisdiction")
                        .font(Theme.Fonts.roundedCaption())
                        .foregroundColor(.secondary)

                    Picker("Jurisdiction", selection: $selection) {
                        ForEach(Jurisdiction.allCases) { jurisdiction in
                            Text(jurisdiction.rawValue)
                                .tag(jurisdiction)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.primary)
                    .labelsHidden()
                }

                Spacer()

                Text(selection.abbreviation)
                    .font(Theme.Fonts.roundedHeadline())
                    .foregroundColor(.blue)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.blue.opacity(0.15))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var jurisdiction: Jurisdiction = .ontario

        var body: some View {
            JurisdictionPicker(selection: $jurisdiction)
                .padding()
                .background(Theme.Colors.background)
        }
    }

    return PreviewWrapper()
}
