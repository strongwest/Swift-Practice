//
//  BadgeDetailView.swift
//  GratefulMoments
//
//  Created by 강서현 on 4/23/26.
//

import SwiftUI

struct BadgeDetailView: View {
    var badge: Badge
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Image(badge.details.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140, height: 140)
                Text(badge.details.title)
                    .font(.title.bold())
                Text(badge.details.congratulatoryMessage)
                    .font(.body)
                Spacer()
                // 옵셔널 바인딩 if let(만약 있다면 ~라고 처리)
                if let timestamp = badge.timestamp {
                    Text(timestamp, style: .date)
                        .font(.caption2.bold())
                }
            }
            .padding()
            .frame(width: 320)
            .frame(minHeight: 410)
            .fixedSize()
            .multilineTextAlignment(.center)
            .foregroundStyle(.white)
            .background(badge.details.color.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 16.0))
        }
        .scrollBounceBehavior(.basedOnSize)
        .defaultScrollAnchor(.center, for: .alignment)
        // 스크롤 위치의 기본값을 중간으로
    }
}

#Preview {
    BadgeDetailView(badge: .sample)
}

#Preview("Spanish language"){
    BadgeDetailView(badge: .sample)
        .environment(\.locale, Locale(identifier: "es"))
    // Locae: es : 스페인어 국제 코드
}
