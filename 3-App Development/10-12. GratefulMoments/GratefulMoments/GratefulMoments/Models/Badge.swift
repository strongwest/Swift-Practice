//
//  Badge.swift
//  GratefulMoments
//
//  Created by 강서현 on 4/23/26.
//

import Foundation
import SwiftData

/// Use `timestamp` to determine if a badge is unlocked.
/// A `Moment` may be deleted but the timestamp stays.
/// Once awarded, badges aren't relocked.

@Model
class Badge {
    var details: BadgeDetails // enum
    var moment: Moment?
    var timestamp: Date?
    
    init(details: BadgeDetails) {
        self.details = details
        self.moment = nil
        // 뱃지는 앱이 실행되고나서 생성되므로 초기화자를 비워놓는다
        self.timestamp = nil
        // 모먼트가 삭제돼도 뱃지는 삭제되지 않으므로 타임스탬프 필요
    }
    
}

// 샘플 데이터
extension Badge {
    static var sample: Badge {
        let badge = Badge(details: .firstEntry)
        badge.timestamp = .now
        return badge
    }
}
