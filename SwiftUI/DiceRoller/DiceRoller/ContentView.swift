//
//  ContentView.swift
//  DiceRoller
//
//  Created by 강서현 on 3/28/26.
//

import SwiftUI

struct ContentView: View {
    @State private var numberOfDice: Int = 2
    
    var body: some View {
        VStack {
            Text("Dice Roller")
                .font(.largeTitle
                    .lowercaseSmallCaps()
                    .bold())
                .foregroundStyle(.white)

            HStack{
                ForEach(1...numberOfDice, id: \.description) { _ in DiceView()
                }
                // id를 부여함으로써 동일한 뷰의 경유 렌더링을 하지 않아도 된다고 조작? 암묵적 동일성?을 유지하기 위함
            }
            
            HStack {
                Button("Remove Dice", systemImage: "minus.circle.fill"){
                    withAnimation {
                        numberOfDice -= 1
                    }
                }
                .disabled(numberOfDice == 1)
                

                //Button("Remove Dice", systemImage: "minus.circle.fill", action:{
                //    withAnimation {
                //        numberOfDice -= 1
                //    }
                //})
                //.disabled(numberOfDice == 1)
                
                Button("Add Dice", systemImage: "plus.circle.fill"){
                    withAnimation {
                        numberOfDice += 1
                    }
                }
                .disabled(numberOfDice == 5)
            }
            .padding()
            .labelStyle(.iconOnly)
            .font(.title)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.appBackground)
        .tint(.white)
    }
}

#Preview {
    ContentView()
}
