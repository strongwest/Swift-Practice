import Foundation


@Observable
class Tile: Identifiable {
    let id = UUID()

    var word: String
    var position: CGPoint = .zero
    // When flipped, show a checkmark instead of the word and icon
    var flipped = false

    init(word: String) {
        self.word = word
    }

    var icon: String {
        Vocabulary.icons[word] ?? "🤷"
        // word에 해당하는 아이콘을 찾고 없으면 " " 반환
        // Vocabulary.icons[word] << 딕셔너리 조회
        // A ?? B << A 있으면 A, 없으면 B
    }
}

extension Tile: Equatable {
    static func == (lhs: Tile, rhs: Tile) -> Bool {
        lhs.id == rhs.id
    }
}
