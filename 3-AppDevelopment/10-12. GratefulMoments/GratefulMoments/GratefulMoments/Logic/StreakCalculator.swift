//
//  StreakCalculator.swift
//  GratefulMoments
//
//  Created by 강서현 on 4/27/26.
//

import Foundation

struct StreakCalculator {
    let calendar = Calendar.current
    
    ///Counts the number of days in a row a moment has been saved
    ///
    ///Days are measured from the end of the day, rather than whatever time of the day it is currently
    /// - precondition: `moments` must be sorted by timestamp, from earliest to latest
    func calculateStreak(for moments: [Moment]) -> Int {
        let startOfToday = calendar.startOfDay(for: .now)
        let endOfToday = calendar.date(byAdding: DateComponents(day: 1, second: -1), to: startOfToday)!
        // 날짜 하루 더하고 1초 빼서 하루의 끝 만들기
        // ! : nil 아니라고 확신(강제 언래핑Force Unwrapping)
        
        // ex. [ 0, 0, 1, 2, 4, 5 ] 모먼트가 오늘로부터 몇 일 전인지 배열 만들기, 배열이 연속인지 확인
        let daysAgoArray = moments
            .reversed() // 최신 -> 과거 순서
            .map(\.timestamp) // 타임스탬프만 꺼내기 [Moment] -> [Date]
            .map { calendar.dateComponents([.day], from: $0, to: endOfToday) } // dateComponents 날짜 계산하는 파라미터
        // 결과타임 [Date] -> [DateComponents]
            .compactMap {$0.day} // day 값만 꺼내고 nil 제거
        // 결과 타입 -> [Int]
        
        var streak = 0
        for daysAgo in daysAgoArray {
            
            if daysAgo == streak {
                streak += 1
            }
            
        }
        
        return streak
    }
}

