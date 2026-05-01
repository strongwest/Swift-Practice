//
//  Player.swift
//  ScoreKeeper
//
//  Created by 강서현 on 4/7/26.
//

import Foundation

struct Player: Identifiable {
    let id = UUID()
    // 중복 이름을 가질 수 있음. 인스턴스 각각이 고유함. Universally Unique Identifier
    // id는 변수(property), UUID는 데이터 타입(type)
    // id 변수가 필요하고 그것의 데이터 타입으로 UUID가 많이 쓰인다
    
    var name: String
    var score: Int
}
    
    extension Player: Equatable {
        static func == (lhs: Player, rhs: Player) -> Bool {
            lhs.name == rhs.name && lhs.score == rhs.score
    }
    // 기존 타입에 기능 확장
    // 익스텐션을 쓰는 이유는 외부 라이브러리나 프레임워크를 가져다 사용했다면 원본 소스를 수정하지 못한다. 이 처럼 외부에서 가져온 타입에 내가 원하는 기능을 추가하고자 할 때 익스텐션을 사용합니다.
    // extension 확장할 타입이름 { 추가될 기능 }
    // Equatable: 타입끼리 비교하기 위해 필수. num, str는 == 바로 쓸 수 있는데 우리가 만든 구조체나 클래스 인스턴스를 == 로 비교하려면 이쿼터블이 필요하다.
}
