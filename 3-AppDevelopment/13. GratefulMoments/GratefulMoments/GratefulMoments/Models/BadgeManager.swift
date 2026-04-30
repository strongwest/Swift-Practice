//
//  BadgeManager.swift
//  GratefulMoments
//
//  Created by 강서현 on 4/23/26.
//

import Foundation
import SwiftData

// 뱃지를 SwiftData에 저장하고 requirements가 충족될 때 배지를 부여
class BadgeManager {
    private let modelContainer: ModelContainer
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    func unlockBadges(newMoment: Moment) throws {
        let context = modelContainer.mainContext
        let moments = try context.fetch(FetchDescriptor<Moment>())
        let lockedBadges = try context.fetch(FetchDescriptor<Badge>(predicate: #Predicate { $0.timestamp == nil }))
        // 잠긴 뱃지 가져오기 위해 타임스탬프가 없는 뱃지를 필터링predicate
        
        var newlyUnlocked: [Badge] = []
        
        for badge in lockedBadges {
            // 잠금 해제된 뱃지를 찾기 위한 루프, lockedBadges 안에서 순회
            switch badge.details {
            case .firstEntry where moments.count >= 1,
                    // 모먼트가 최소 1개 생기면 'firstEntry' 해금
                    .fiveStars where moments.count >= 5,
                    .shutterbug where moments.count(where: { $0.image != nil}) >= 3,
                    .expressive where moments.count(where: { $0.image != nil && !$0.note.isEmpty}) >= 5,
                    .perfectTen where moments.count >= 10 && lockedBadges.count == 1:
                    // 잠겨있는 뱃지가 perfectTen 하나만 남았다는 뜻
                newlyUnlocked.append(badge)
                // newlyUnlocked 배열에 추가
            default:
                continue
            }
        }
        
        // 배열에 추가된 뱃지에 해당 모먼트와 타임스탬프 추가
        for badge in newlyUnlocked {
            badge.moment = newMoment
            badge.timestamp = newMoment.timestamp
        }
        
    }
    
    // If Needed : 함수가 호출될 때마다 뱃지가 매번 저장되지는 않음을 의미
    func loadBadgesIfNeeded() throws {
        let context = modelContainer.mainContext
        var fetchDescriptor = FetchDescriptor<Badge>()
        fetchDescriptor.fetchLimit = 1
        let existingBadges = try context.fetch(fetchDescriptor)
        if existingBadges.isEmpty {
            for details in BadgeDetails.allCases {
                context.insert(Badge(details: details))
            }
        }
    }
}
