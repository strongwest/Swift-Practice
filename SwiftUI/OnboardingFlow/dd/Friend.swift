//
//  Untitled.swift
//  OnboardingFlow
//
//  Created by 강서현 on 3/31/26.
//

import Foundation
import SwiftData

@Model
class Friend {
    var name: String
    var birthday: Date
    
    init(name: String, birthday: Date) {
        self.name = name
        self.birthday = birthday
    }
    
    var isBirthdayToday: Bool {
            Calendar.current.isDateInToday(birthday)
        }
    
}
