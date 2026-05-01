//
//  ScoreKeeperTests.swift
//  ScoreKeeperTests
//
//  Created by 강서현 on 4/8/26.
//

import Testing
@testable import ScoreKeeper
// 기존 앱과 별개의 파일이기 때문에 불러와야 함

struct ScoreKeeperTests {

    @Test("Reset player scores", arguments: [0, 10, 20])
    // test에 전송하려는 어노테이션 인수.. 그게 뭔데?
    func resetScores(to newValue: Int) async throws {
        var scoreboard = Scoreboard(players: [
            Player(name: "River", score: 0),
            Player(name: "Zen", score: 5)
        ])
        scoreboard.resetScores(to: newValue)
        
        for player in scoreboard.players {
            #expect(player.score == newValue)
        }
        // for loop 설정, 플레이어의 스코어가 0이 될 것이라고 #예상 << 이건 왜 하는거지?
        // 아하 테스트 프레임워크는 #expect로 설정해서 만약 fail이 나오면 이 코드는 틀렸음을 알 수 있는 듯
    }
    
    @Test("Highest score wins")
    func highestScoreWins() {
        let scoreboard = Scoreboard(
            players: [
                Player(name: "River", score: 0),
                Player(name: "Zen", score: 4),
            ],
            state: .gameOver,
            doesHighestScoreWin: true
        )
        let winners = scoreboard.winners
        #expect(winners == [Player(name: "Zen", score: 4)])
    }
    
    @Test("Lowest score wins")
    func lowestScoreWins() {
        let scoreboard = Scoreboard(
            players: [
                Player(name: "River", score: 0),
                Player(name: "Zen", score: 4),
            ],
            state: .gameOver,
            doesHighestScoreWin: false
        )
        let winners = scoreboard.winners
        #expect(winners == [Player(name: "River", score: 0)])
    }
    
    

}
