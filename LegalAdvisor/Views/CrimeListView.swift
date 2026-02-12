import SwiftUI

struct CrimeListView: View {
    let category: CrimeCategory
    let jurisdiction: Jurisdiction

    @State private var searchText = ""

    private var crimes: [Crime] {
        let categorycrimes = CrimeDatabase.shared.crimes(for: category)
        if searchText.isEmpty {
            return categorycrimes
        }
        return categorycrimes.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.section.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                categoryHeader

                SearchBar(text: $searchText, placeholder: "Search \(category.rawValue.lowercased())...")
                    .padding(.horizontal)

                LazyVStack(spacing: 12) {
                    ForEach(crimes) { crime in
                        NavigationLink(destination: CrimeDetailView(crime: crime, jurisdiction: jurisdiction)) {
                            CrimeRow(crime: crime)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Theme.Colors.background)
        .navigationTitle(category.rawValue)
        .navigationBarTitleDisplayMode(.large)
    }

    private var categoryHeader: some View {
        GlowingCard(color: category.color) {
            HStack(spacing: 16) {
                Image(systemName: category.icon)
                    .font(.system(size: 36))
                    .foregroundColor(category.color)
                    .glowEffect(color: category.color)

                VStack(alignment: .leading, spacing: 4) {
                    Text("\(crimes.count) Offenses")
                        .font(Theme.Fonts.roundedHeadline())
                        .foregroundColor(.primary)

                    Text(category.description)
                        .font(Theme.Fonts.roundedCaption())
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }

                Spacer()
            }
            .padding()
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        CrimeListView(category: .violentCrimes, jurisdiction: .ontario)
    }
}
