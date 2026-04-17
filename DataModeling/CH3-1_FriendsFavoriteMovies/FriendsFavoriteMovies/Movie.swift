//
//  Movie.swift
//  FriendsFavoriteMovies
//
//  Created by 강서현 on 4/12/26.
//

import Foundation
import SwiftData

@Model
class Movie {
    var title: String
    var releaseDate: Date
    
    init(title: String, releaseDate: Date){
        self.title = title
        self.releaseDate = releaseDate
    }
    
    static let sampleData = [
        Movie(title: "Netemo Sametemo", releaseDate: Date(timeIntervalSinceReferenceDate: -402_000_000)),
        Movie(title: "Toy Story", releaseDate: Date(timeIntervalSinceReferenceDate: -20_000_000)),
        Movie(title: "Project Hail Mary", releaseDate: Date(timeIntervalSinceReferenceDate: 300_000_000)),
        Movie(title: "Chainsaw Man", releaseDate: Date(timeIntervalSinceReferenceDate: 120_000_000)),
        Movie(title: "The King's Warden", releaseDate: Date(timeIntervalSinceReferenceDate: 550_000_000)),
        Movie(title: "Super Mario", releaseDate: Date(timeIntervalSinceReferenceDate: -1_702_000_000)),
        
    ]
    
}
