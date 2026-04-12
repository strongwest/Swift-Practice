//
//  Friend.swift
//  FriendsFavoriteMovies
//
//  Created by 강서현 on 4/12/26.
//

import Foundation
import SwiftData

@Model
// 모델은 이닛이 필요
class Friend {
    var name: String
    
    init(name: String){
        self.name = name
    }
    
    // static let 다시 공부
    static let sampleData = [
        Friend(name: "River"),
        Friend(name: "Zen"),
        Friend(name: "Grace"),
        Friend(name: "Youmei"),
        Friend(name: "Bin"),
    ]
}
