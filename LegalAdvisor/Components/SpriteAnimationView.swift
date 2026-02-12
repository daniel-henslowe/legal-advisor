import SwiftUI

struct RobotCharacterView: View {
    var body: some View {
        Image("RobotSprite")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 120, height: 120)
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
