//
//  SettingsView.swift
//  ScoreKeeper
//
//  Created by 강서현 on 4/8/26.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var doesHighestScoreWin: Bool
    @Binding var startingPoints: Int
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text("Game Rules")
                .font(.headline)
            Divider()
            Picker("Win condition", selection: $doesHighestScoreWin) {
                Text("Highest Score Wins").tag(true)
                Text("Lowest Score Wins").tag(false)
            }
            
            Picker("Starting Points", selection: $startingPoints) {
                Text("0 starting points")
                    .tag(0)
                Text("10 starting points")
                    .tag(10)
                Text("20 starting points")
                    .tag(20)
            }
            // tag는 picker가 실제로 선택하는 값. 태그 없으면 코드 안 돌아감. tag의 값이 selection $starting.. 에 저장됨
            
        }
        .padding()
        .background(.thinMaterial, in: .rect(cornerRadius: 10.0))
    }
}

#Preview {
    @Previewable @State var doesHighestScoreWin = true
    @Previewable @State var startingPoints = 10
    // 프리뷰 내에서 @State를 선언할 수 있게 함
    SettingsView(doesHighestScoreWin: $doesHighestScoreWin, startingPoints: $startingPoints)
}
