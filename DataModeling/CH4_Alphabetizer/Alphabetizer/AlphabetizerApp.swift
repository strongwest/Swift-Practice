import SwiftUI

@main
struct AlphabetizerApp: App {
    @State private var alphabetizer = Alphabetizer()
    // Observable이 있어서 저장/검색될 수 있음
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(alphabetizer)
        }
    }
}
