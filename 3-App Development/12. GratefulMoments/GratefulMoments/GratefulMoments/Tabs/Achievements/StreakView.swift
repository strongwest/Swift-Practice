//
//  StreakView.swift
//  GratefulMoments
//
//  Created by 강서현 on 4/27/26.
//

import SwiftUI

struct StreakView: View {
    var numberOfDays: Int
    
    var body: some View {
        Hexagon(borderColor: .secondary) {
            VStack(spacing: 0) {
                Text("Streak \(Image(systemName: "flame.fill"))")
                    .foregroundStyle(.ember)
//                Text("\(numberOfDays)")
//                    .font(.system(size: 70))
//                Text("Days")
                Text(attributedText)
                    .multilineTextAlignment(.center)
            }
            .font(.callout)
        }
        
        var attributedText: AttributedString {
            var attributedString = AttributedString(localized: "^[\(numberOfDays) \nDays](inflect: true)")
            // \n 문단 띄어쓰기
            if let range = attributedString.range(of: "\(numberOfDays)") {
                attributedString[range].font = .system(size: 70)
                // 부분 변화주기
            }
            return attributedString
        }
        
    }
}

#Preview {
    StreakView(numberOfDays: 0)
    StreakView(numberOfDays: 1)
    StreakView(numberOfDays: 23)
}
