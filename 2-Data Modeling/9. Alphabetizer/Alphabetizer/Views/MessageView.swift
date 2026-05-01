import SwiftUI

struct MessageView: View {
    
    @Environment(Alphabetizer.self) private var alphabetizer
//    // TODO: Different messages after winning or losing the game

    var body: some View {
        Text(alphabetizer.message.rawValue)
            .font(.largeTitle)
    }
}

#Preview {
    let alphabetizer = Alphabetizer()
    alphabetizer.message = .youWin
    return MessageView()
        .environment(alphabetizer)
}
