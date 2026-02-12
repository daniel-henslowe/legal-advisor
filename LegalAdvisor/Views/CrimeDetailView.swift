import SwiftUI

struct CrimeDetailView: View {
    let crime: Crime
    let jurisdiction: Jurisdiction

    @State private var age: Double = 25

    private var sentenceResult: SentenceResult {
        SentenceCalculator.calculateSentence(for: crime, age: Int(age), jurisdiction: jurisdiction)
    }

    private var isYouth: Bool {
        Int(age) >= 12 && Int(age) <= 17
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerCard
                sentenceCard
                ageSelector
                detailsCard
                if !sentenceResult.notes.isEmpty {
                    notesCard
                }
                sourceCard
                disclaimerCard
            }
            .padding()
        }
        .background(Theme.Colors.background)
        .navigationTitle(crime.name)
        .navigationBarTitleDisplayMode(.large)
    }

    private var headerCard: some View {
        GlowingCard(color: crime.category.color) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: crime.category.icon)
                        .font(.title2)
                        .foregroundColor(crime.category.color)
                        .glowEffect(color: crime.category.color)

                    Text(crime.category.rawValue)
                        .font(Theme.Fonts.roundedCaption())
                        .foregroundColor(.secondary)

                    Spacer()

                    Text(crime.formattedSection)
                        .font(Theme.Fonts.roundedCaption())
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(crime.category.color.opacity(0.2))
                        .foregroundColor(crime.category.color)
                        .clipShape(Capsule())
                }

                Text(crime.description)
                    .font(Theme.Fonts.roundedBody())
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
        }
    }

    private var sentenceCard: some View {
        GlowingCard(color: isYouth ? .orange : .blue) {
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Sentence Range")
                            .font(Theme.Fonts.roundedCaption())
                            .foregroundColor(.secondary)

                        Text(sentenceResult.formattedRange)
                            .font(Theme.Fonts.roundedTitle2())
                            .foregroundColor(.primary)
                    }

                    Spacer()

                    Image(systemName: isYouth ? "figure.child" : "person.fill")
                        .font(.system(size: 32))
                        .foregroundColor(isYouth ? .orange : .blue)
                        .glowEffect(color: isYouth ? .orange : .blue)
                }

                if isYouth {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.orange)

                        Text("Youth Criminal Justice Act applies")
                            .font(Theme.Fonts.roundedCaption())
                            .foregroundColor(.orange)

                        Spacer()
                    }
                    .padding(10)
                    .background(Color.orange.opacity(0.15))
                    .cornerRadius(8)
                }
            }
            .padding()
        }
    }

    private var ageSelector: some View {
        GlowingCard(color: .gray) {
            VStack(spacing: 16) {
                HStack {
                    Text("Offender Age")
                        .font(Theme.Fonts.roundedHeadline())
                        .foregroundColor(.primary)

                    Spacer()

                    Text("\(Int(age)) years")
                        .font(Theme.Fonts.roundedTitle3())
                        .foregroundColor(isYouth ? .orange : .blue)
                }

                Slider(value: $age, in: 12...65, step: 1)
                    .tint(isYouth ? .orange : .blue)

                HStack {
                    Text("12")
                        .font(Theme.Fonts.roundedCaption())
                        .foregroundColor(.secondary)

                    Spacer()

                    if isYouth {
                        Text("Youth (12-17)")
                            .font(Theme.Fonts.roundedCaption())
                            .foregroundColor(.orange)
                    } else {
                        Text("Adult (18+)")
                            .font(Theme.Fonts.roundedCaption())
                            .foregroundColor(.blue)
                    }

                    Spacer()

                    Text("65")
                        .font(Theme.Fonts.roundedCaption())
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
    }

    private var detailsCard: some View {
        GlowingCard(color: .gray) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Details")
                    .font(Theme.Fonts.roundedHeadline())
                    .foregroundColor(.primary)

                detailRow(title: "Statute", value: crime.statute.rawValue)
                detailRow(title: "Section", value: crime.section)
                detailRow(title: "Jurisdiction", value: jurisdiction.rawValue)
                detailRow(title: "Offense Type", value: offenseType)

                if let min = crime.minimumSentence {
                    detailRow(title: "Mandatory Minimum", value: min.formatted)
                }

                detailRow(title: "Maximum Penalty", value: crime.maximumSentence.formatted)
            }
            .padding()
        }
    }

    private var offenseType: String {
        if crime.maximumSentence.type == .lifeImprisonment {
            return "Indictable"
        } else if crime.maximumSentence.value <= 2 && crime.maximumSentence.unit == .years {
            return "Summary / Hybrid"
        } else {
            return "Hybrid"
        }
    }

    private var notesCard: some View {
        GlowingCard(color: .yellow) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "lightbulb.fill")
                        .foregroundColor(.yellow)

                    Text("Important Notes")
                        .font(Theme.Fonts.roundedHeadline())
                        .foregroundColor(.primary)
                }

                ForEach(sentenceResult.notes, id: \.self) { note in
                    HStack(alignment: .top, spacing: 8) {
                        Circle()
                            .fill(Color.yellow)
                            .frame(width: 6, height: 6)
                            .padding(.top, 6)

                        Text(note)
                            .font(Theme.Fonts.roundedSubheadline())
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
        }
    }

    private var sourceCard: some View {
        Button {
            if let url = crime.sectionURL {
                UIApplication.shared.open(url)
            }
        } label: {
            PressableCard {
                GlowingCard(color: .blue) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "book.closed.fill")
                                .foregroundColor(.blue)

                            Text("Source")
                                .font(Theme.Fonts.roundedHeadline())
                                .foregroundColor(.primary)

                            Spacer()

                            Image(systemName: "arrow.up.right.square")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text(crime.statute.rawValue)
                                .font(Theme.Fonts.roundedSubheadline())
                                .foregroundColor(.primary)

                            Text("Data Version: \(CrimeDatabase.shared.dataVersion)")
                                .font(Theme.Fonts.roundedCaption())
                                .foregroundColor(.secondary)

                            Text("Last Updated: \(CrimeDatabase.shared.lastUpdated)")
                                .font(Theme.Fonts.roundedCaption())
                                .foregroundColor(.secondary)
                        }

                        HStack {
                            Image(systemName: "link")
                            Text("View Section \(crime.section.components(separatedBy: "(").first ?? crime.section) on Justice Laws")
                        }
                        .font(Theme.Fonts.roundedCaption())
                        .foregroundColor(.blue)
                    }
                    .padding()
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var disclaimerCard: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)

            Text("This information is for educational purposes only and does not constitute legal advice. Consult a qualified lawyer for legal matters.")
                .font(Theme.Fonts.roundedCaption())
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.red.opacity(0.1))
        .cornerRadius(Theme.cornerRadius)
    }

    private func detailRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(Theme.Fonts.roundedSubheadline())
                .foregroundColor(.secondary)

            Spacer()

            Text(value)
                .font(Theme.Fonts.roundedSubheadline())
                .foregroundColor(.primary)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    NavigationStack {
        CrimeDetailView(
            crime: CrimeDatabase.shared.crimes.first!,
            jurisdiction: .ontario
        )
    }
}
