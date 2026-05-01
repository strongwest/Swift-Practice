//
//  AchievementsView.swift
//  GratefulMoments
//
//  Created by 강서현 on 4/26/26.
//

import SwiftUI
import SwiftData

struct AchievementsView: View {
    // 잠금해제된 뱃지 가져오기
    @Query(filter: #Predicate<Badge> {$0.timestamp != nil})
    private var unlockedBadges: [Badge]
    
    // 잠겨있는 뱃지 가져오기
    @Query(filter: #Predicate<Badge> {$0.timestamp == nil})
    private var lockedBadges: [Badge]
    
    @Query(sort: \Moment.timestamp)
    private var moments: [Moment]
    
    var body: some View {
        NavigationStack{
            ScrollView{
                contentStack
            }
            .navigationTitle("Achievements")
        }
    }
    
    private var contentStack: some View {
        VStack(alignment: .leading) {
            StreakView(numberOfDays: StreakCalculator().calculateStreak(for: moments))
                .frame(maxWidth: .infinity)
            // 뱃지가 하나라도 있어야 해당 섹션 보여주기
            if !unlockedBadges.isEmpty {
                header("Your Badges")
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(sortedUnlockedBadges) { badge in
                            UnlockedBadgeView(badge: badge)
                        }
                    }
                }
                .scrollClipDisabled()
                .scrollIndicators(.hidden)
            }
            
            if !lockedBadges.isEmpty {
                header("Locked Badges")
                ForEach(sortedLockedBadges) { badge in
                    LockedBadgeView(badge: badge)
                }
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
    
    func header(_ text: String) -> some View {
        // _ : 외부 파라미터 생략. 호출할 때 header("")로 바로 호출. header(name: "") 이렇게 말고 간단하게.
        Text(text)
            .font(.subheadline.bold())
            .padding()
    }
    
    private var sortedLockedBadges: [Badge] {
        lockedBadges.sorted {
            $0.details.rawValue < $1.details.rawValue
        }
    }
    
    /// - precondition: 'unlockedBadges' must have a timestamp
    // 해금된 뱃지들을 1. 시간순으로 정렬, 2. 제목순으로 정렬
    private var sortedUnlockedBadges: [Badge] {
        unlockedBadges.sorted {
            ($0.timestamp!, $0.details.title) < ($1.timestamp, $1.details.title) as! (Date, String)
        }
    }
    
}

#Preview {
    AchievementsView()
        .sampleDataContainer()
    // 샘플 데이터 연결
}
