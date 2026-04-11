//
//  WelcomePage.swift
//  OnboardingFlow
//
//  Created by 강서현 on 3/27/26.
//

import SwiftUI

struct WelcomePage: View {
    var body: some View {

        VStack {
            
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 150, height: 150)
                    .foregroundStyle(.tint)
                
                Image(systemName: "figure.2.and.child.holdinghands")
                    .font(.system(size: 70))
                    .foregroundStyle(.white)
            }
            
            Text("Welcome to River's App")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
                //.border(.black, width: 1.5)
            
            Text("이것은 설명입니다.")
                .font(.title2)
                //.border(.black, width: 1.5)
        }
        .border(.red, width: 1.5)
        .padding()
        //.border(.purple, width: 1.5)
    }
}

#Preview {
    WelcomePage()
}
