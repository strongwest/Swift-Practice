//
//  Scorer.swift
//  HikingSurvey
//
//  Created by 강서현 on 4/30/26.
//

import Foundation
import NaturalLanguage
// 샘플 응답의 감정값을 추출해내는 자연어 프레임워크 구축

class Scorer {
    let tagger = NLTagger(tagSchemes: [.sentimentScore])
    // 텍스트를 감정 점수 기준으로 분석하는 태거 선언
    
    func score(_ text: String) -> Double {
        var sentimentScore = 0.0
        tagger.string = text
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .paragraph, scheme: .sentimentScore, options: []) { sentimentTag, _ in
            // if let 이랑 let 따로 아니고 ,(and)로 연결되어 if가 두 let을 동시에 검사
            if let sentimentString = sentimentTag?.rawValue,
               // 태그값이 있으면 문자열rawValue로, 문자열이 있으면 점수Double로 변환하여 sentimentScore에 저장
               let score = Double(sentimentString) {
                sentimentScore = score
                return true
            }
            return false
        }
        return sentimentScore
    }
    
}
