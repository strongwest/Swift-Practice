import Foundation
import SwiftData

@Model
class Movie {
    var title: String
    var releaseDate: Date
    var favoritedBy = [Friend]()
    // friend와 movie 의 관계를 만드는 과정
    // friend:movie는 일대다 관계이므로 [Friend]를 배열로 만든다

    init(title: String, releaseDate: Date) {
        self.title = title
        self.releaseDate = releaseDate
    }

    static let sampleData = [
        Movie(title: "Amusing Space Traveler 3",
              releaseDate: Date(timeIntervalSinceReferenceDate: -402_000_000)),
        Movie(title: "Difficult Cat",
              releaseDate: Date(timeIntervalSinceReferenceDate: -20_000_000)),
        Movie(title: "Electrifying Trek",
              releaseDate: Date(timeIntervalSinceReferenceDate: 300_000_000)),
        Movie(title: "Reckless Train Ride 2",
              releaseDate: Date(timeIntervalSinceReferenceDate: 120_000_000)),
        Movie(title: "The Last Venture",
              releaseDate: Date(timeIntervalSinceReferenceDate: 550_000_000)),
        Movie(title: "Glamorous Neighbor",
              releaseDate: Date(timeIntervalSinceReferenceDate: -1_700_000_000)),
    ]
}
