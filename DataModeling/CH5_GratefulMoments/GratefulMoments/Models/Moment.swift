//
//  Moment.swift
//  GratefulMoments
//
//  Created by 강서현 on 4/19/26.
//

import Foundation
import SwiftData
import UIKit

@Model
class Moment {
    var title: String
    var note: String
    var ImageData: Data?
    var timestamp: Date
    
    init(title: String, note: String, ImageData: Data? = nil, timestamp: Date) {
        self.title = title
        self.note = note
        self.ImageData = ImageData
        self.timestamp = timestamp
    }
}

extension Moment {
    static let sample = sampleData[0]
    static let longTextsample = sampleData[1]
    static let imagesample = sampleData[4]
    
    static let sampleData = [
        
        Moment(title: "🍅🥳",
               note: "Picked my first homegrown tomato!", timestamp: .now
                ),
                Moment(
                    title: "Passed the test!",
                    note: "The chem exam was tough, but I think I did well 🙌 I’m so glad I reached out to Guillermo and Lee for a study session. It really helped!",
                    ImageData: UIImage(named: "Study")?.pngData(), timestamp: .now
                ),
                Moment(
                    title: "Down time",
                    note: "So grateful for a relaxing evening after a busy week.",
                    ImageData: UIImage(named: "Relax")?.pngData(), timestamp: .now
                ),
                Moment(
                    title: "Family ❤️",
                    note: "", timestamp: .now
                ),
                Moment(
                    title: "Rock on!",
                    note: "Went to a great concert with Blair 🎶",
                    ImageData: UIImage(named: "Concert")?.pngData(), timestamp: .now
                )
        
    ]
}
