import SwiftUI

struct ContentView: View {
    @AppStorage("hasAcceptedDisclaimer") private var hasAcceptedDisclaimer = false

    var body: some View {
        ZStack {
            NavigationStack {
                HomeView()
            }

            if !hasAcceptedDisclaimer {
                DisclaimerView(hasAcceptedDisclaimer: $hasAcceptedDisclaimer)
                    .transition(.opacity.combined(with: .scale(scale: 0.9)))
            }
        }
        .animation(.spring(response: 0.4), value: hasAcceptedDisclaimer)
    }
}

#Preview {
    ContentView()
}
