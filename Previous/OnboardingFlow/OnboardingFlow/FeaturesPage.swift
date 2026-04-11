//
//  FeaturesPage.swift
//  OnboardingFlow
//
//  Created by 강서현 on 3/28/26.
//

import SwiftUI

struct FeaturesPage: View {
    var body: some View {
        VStack(spacing: 30){
            Text("Features")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom)
                .padding(.top, 80)
            
            FeatureCard(iconName: "sun.and.horizon.fill", description: "제 이름은 리버고 이건 설명이에요. 이제 카드 만드는 방법을 알게 되었어요.")
            
            FeatureCard(iconName: "cloud.rainbow.half.fill", description: "아이콘 정말 귀엽다!")
            
            Spacer()
            
        }
        .padding()
    }
}

#Preview {
    FeaturesPage()
        .frame(maxHeight: .infinity)
        .background(Gradient(colors: gradientColors))
        .foregroundStyle(.white)
}
