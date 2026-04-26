//
//  HexagonLayout.swift
//  GratefulMoments
//
//  Created by 강서현 on 4/20/26.
//

import SwiftUI

// 서로다른 레이아웃 크기 지정
// enum 사용시 새로운 사이즈를 추가하기에 좋다
enum HexagonLayout {
    case standard
    case large
    
    var size: CGFloat {
        switch self {
        case .standard:
            return 200.0
        case .large:
            return 350.0
        }
    }

// variable 설정. 패딩을 백분율로 계산
    var timestampBottomPadding: CGFloat {
        0.08
    }
    var textBottomPadding: CGFloat {
        0.25
    }
    var timestampHeight: CGFloat {
        size * (textBottomPadding - timestampBottomPadding)
    } // 이해 안되네
    
// 글꼴 switch
    var titleFont: Font {
        switch self {
        case .standard:
            return .headline
        case .large:
            return .title.bold()
        }
    }
    
    var bodyFont: Font {
        switch self {
        case .standard:
            return .caption2
        case .large:
            return .body
        }
    }
}
