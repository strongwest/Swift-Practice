import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Moments", systemImage: "sun.max.fill") {
                MomentsView()
            }
            Tab("Achievements", systemImage: "medal.fill") {
                AchievementsView()
            }
        }
    }
}

#Preview {
    ContentView()
        .sampleDataContainer()
}
