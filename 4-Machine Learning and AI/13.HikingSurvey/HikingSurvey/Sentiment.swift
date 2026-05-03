//
//  Sentiment.swift
//  HikingSurvey
//
//  Created by 강서현 on 5/1/26.
//

import Foundation
import SwiftUI
import Charts

// Plottable 프로토콜: 차트(막대, 선, 점 등)에 표시될 수 있는 데이터 타입을 정의
enum Sentiment: String, Plottable {
    case positive = "Positive"
    case negative = "Negative"
    case moderate = "Moderate"
    
    // 입력받은 score에 따라 sentiment가 달라지는 초기화자 switch문 설정
    init(_ score: Double){
        if score > 0.2 {
            self = .positive
        } else if score < -0.2 {
            self = .negative
        } else {
            self = .moderate
        }
    }
    
    var icon: String {
        switch self {
        case .positive:
            return "chevron.up.2"
        case .negative:
            return "chevron.down.2"
        case .moderate:
            return "minus"
        }
    }
    
    var sentimentColor: Color {
        switch self {
        case .positive:
            return Color(red: 0.99, green: 0.49, blue: 0.00)
        case .negative:
            return Color(red: 0.08, green: 0.22, blue: 0.41)
        case .moderate:
            return Color(red: 0.00, green: 0.44, blue: 0.49)
        }
    }
}
