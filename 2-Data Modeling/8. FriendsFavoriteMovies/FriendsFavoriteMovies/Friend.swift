import Foundation
import SwiftData

@Model
class Friend {
    var name: String
    var favoriteMovie: Movie?
    // ?: 옵셔널, 선택적 유형. Movie가 있을수도 없을수도

    init(name: String) {
        self.name = name
    }

    static let sampleData = [
        Friend(name: "River"),
        Friend(name: "Zen"),
        Friend(name: "Youmei"),
        Friend(name: "Grace"),
        Friend(name: "Ray"),
    ]
}
