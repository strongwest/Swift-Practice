//
//  GratefulMomentsTests.swift
//  GratefulMomentsTests
//
//  Created by 강서현 on 4/30/26.
//

import Testing
@testable import GratefulMoments
import Foundation

struct StreakCalculatorTests {
    let streakCalculator = StreakCalculator()
    let now = Date.now
    
    // 예상 스트레이크와 일수 배열 struct - 여러 case 테스트하기 위함
    struct Input {
        let expectedStreak: Int
        let days: [Int]
    }
    
    // 버그 보고서와 일치하는 버그 작성
    // 테스트 데이터 인풋
    @Test("Streak calculations", arguments: [
        Input(expectedStreak: 0, days: []),
        
        Input(expectedStreak: 1, days: [0]),
        Input(expectedStreak: 1, days: [-1]),
        Input(expectedStreak: 0, days: [-2]),
        
        Input(expectedStreak: 1, days: [0,0]),
        Input(expectedStreak: 1, days: [-1, -1]),
        Input(expectedStreak: 0, days: [-2, -2]),
        
        Input(expectedStreak: 3, days: [-2, -1, 0]),
        Input(expectedStreak: 2, days: [-3, -1, 0]),
        Input(expectedStreak: 3, days: [-3, -2, -1]),
        Input(expectedStreak: 2, days: [-4, -2, -1]),
        // 실패 test 공통점: 0, '오늘'이 포함됨
    ])
    
    func testCalculations(input: Input) {
        let moments = input.days.map {
            let date = Calendar.current.date(byAdding: .day, value: $0, to: now)!
            return Moment(title: "", note: "", timestamp: date)
        }
        
        let streak = streakCalculator.calculateStreak(for: moments)
        #expect(streak == input.expectedStreak, "\(input.days)")
    }
    
}
