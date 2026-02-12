import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var selectedJurisdiction: Jurisdiction = .federal

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                headerSection

                JurisdictionPicker(selection: $selectedJurisdiction)
                    .padding(.horizontal)

                SearchBar(text: $searchText, placeholder: "Search offenses...")
                    .padding(.horizontal)

                if searchText.isEmpty {
                    categoriesGrid
                } else {
                    searchResults
                }
            }
            .padding(.vertical)
        }
        .background(Theme.Colors.background)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var headerSection: some View {
        VStack(spacing: 8) {
            Image(systemName: "scale.3d")
                .font(.system(size: 48))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .glowEffect(color: .blue, radius: 15)

            Text("Legal Advisor")
                .font(Theme.Fonts.roundedTitle())
                .foregroundColor(.primary)

            Text("Canadian Criminal Law Reference")
                .font(Theme.Fonts.roundedSubheadline())
                .foregroundColor(.secondary)
        }
        .padding(.top, 20)
    }

    private var categoriesGrid: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(CrimeCategory.allCases) { category in
                NavigationLink(destination: CrimeListView(category: category, jurisdiction: selectedJurisdiction)) {
                    CategoryCard(category: category)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal)
    }

    private var searchResults: some View {
        let results = CrimeDatabase.shared.search(searchText)

        return VStack(alignment: .leading, spacing: 12) {
            Text("\(results.count) Results")
                .font(Theme.Fonts.roundedCaption())
                .foregroundColor(.secondary)
                .padding(.horizontal)

            ForEach(results) { crime in
                NavigationLink(destination: CrimeDetailView(crime: crime, jurisdiction: selectedJurisdiction)) {
                    CrimeRow(crime: crime)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
