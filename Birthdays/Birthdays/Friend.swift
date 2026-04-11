//
//  Friend.swift
//  Birthdays
//
//  Created by 강서현 on 4/11/26.
//

import Foundation
import SwiftData

// 모델은 class를 SwiftData에서 관리할 수 있게 함
// 데이터를 모델에 귀속하기 위해 struct를 class로 바꾸기
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
        //birthday가 오늘current인지 계산하는 로직
    }
}
