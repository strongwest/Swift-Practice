//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by 강서현 on 4/7/26.
//

import SwiftUI

struct ContentView: View {
    @State private var scoreboard = Scoreboard()
    @State private var startingPoints = 0

    //Player: 데이터 모델. players: 상태데이터, Player 모델들의 배열 상태
    
//    @State private var players: [String] = ["River", "Kaya", "Grace"]
//    @State private var scores: [Int] = [0,0,0]
//
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Score Keeper")
                .font(.title)
                .bold()
                .padding(.bottom)
            
            SettingsView(doesHighestScoreWin: $scoreboard.doesHighestScoreWin, startingPoints: $startingPoints)
                .disabled(scoreboard.state != .setup)
           
            //그리드는 수평정렬하기 참 좋은 아이임
            Grid {
                GridRow {
                    Text("Player")
                        .gridColumnAlignment(.leading)
                    Text("Score")
                        .opacity(scoreboard.state == .setup ? 0: 1.0)
                }.font(.headline)
                
                /*ForEach(0..<players.count, id: \.description){ index in*/
                ForEach($scoreboard.players) { $player in
                    GridRow{
                        HStack {
                            // winners 배열 안에 player가 있는가? winner인 player에게만 왕관이 씌워지는 것. 조건이 없다면 모든 plyaer에게 왕관이 씌워짐
                            if scoreboard.winners.contains(player) {
                                Image(systemName: "crown.fill").foregroundStyle(Color.yellow)
                            }
                            TextField("Name", text: $player.name)
                        }
                        Text("\(player.score)")
                        //$players: 바인딩 배열, $player: 바인딩 타입 변수를 만들겠다는 선언
                            .opacity(scoreboard.state == .setup ? 0: 1.0)
                        Stepper("\(player.score)", value: $player.score, in: 0...100)
                            .labelsHidden()
                            .opacity(scoreboard.state == .setup ? 0: 1.0)
                    }
                }
            }.padding(.vertical)
                
                //index마다 코드 실행, $배열[i]
                Button("Add Player", systemImage: "plus") {
                    scoreboard.players.append(Player(name: "", score: 0))
                    //scores 배열에 0 추가함으로써 데이터 일관성 유지
                }
                .opacity(scoreboard.state == .setup ? 1.0: 0)
            
            Spacer()
            
            HStack{
                Spacer()
                switch scoreboard.state {
                case .setup:
                    Button("Start Game", systemImage: "play.fill") {
                        scoreboard.state = .playing
                        scoreboard.resetScores(to: startingPoints)
                    }
                case .playing:
                    Button("End Game", systemImage: "stop.fill"){
                        scoreboard.state = .gameOver
                    }
                case .gameOver:
                    Button("Reset Game", systemImage: "arrow.counterclockwise"){
                        scoreboard.state = .setup
                    }
                    // if/else와 비슷하나 가능한 모든 값의 경로 설정해야함
                    // 처음에 default 설정해놓고 추가해나감
                }
                Spacer()
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .tint(.blue)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
