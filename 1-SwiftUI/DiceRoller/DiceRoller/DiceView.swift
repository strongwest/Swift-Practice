//
//  DiceView.swift
//  DiceRoller
//
//  Created by 강서현 on 3/28/26.
//

import SwiftUI

struct DiceView: View {
    @State private var numberOfPips: Int = 1
    //var numberOfPips: Int = 1
    //@State를 사용해야 변화를 모니터링
    
    var body: some View {
        VStack {
            Image(systemName: "die.face.\(numberOfPips).fill")
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100)
                .aspectRatio(1, contentMode: .fit)
                .foregroundStyle(.black, .white)
            
            Button("Roll") {
                
                withAnimation {
                    numberOfPips = Int.random(in: 1...6)
                }
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    DiceView()
}
