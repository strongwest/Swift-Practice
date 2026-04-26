//
//  Scoreboard.swift
//  ScoreKeeper
//
//  Created by 강서현 on 4/7/26.
//

import Foundation

struct Scoreboard {
    var players: [Player] = [
        Player(name: "River", score: 0),
        Player(name: "Zen", score: 0),
        Player(name: "Grace", score: 0),
    ]
    
    var state = GameState.setup
    //기본값 지정
    var doesHighestScoreWin = true
    
    var winners: [Player] {
        guard state == .gameOver else { return [] }
        // 조건들을 걸러냄 if와 비슷. if: ~이면 ~해라 <-> guard: ~아니면 끝내라(빠른 종료) guard ~~ else {} ~~강 아니면 return/throw 해버려라. 이런 느낌. 예외사항을 처리하고 싶을 때. 가독성 좋음
        var winningScore = 0
        if doesHighestScoreWin {
            winningScore = Int.min
            // 첫번째 플레이어와 비교할 점수가 필요하므로 Int.min(기본값0) 사용
            for player in players {
                winningScore = max(player.score, winningScore)
                // 플레이어를 순회하면서 가장 높은max 스코어가 위닝 스코어로 변경됨
            }
        } else {
            winningScore = Int.max
            for player in players {
                winningScore = min(player.score, winningScore)
            }
            
        }
        
        return players.filter { player in
            player.score == winningScore
        }
        // 클로저 필터
    }
    
    mutating func resetScores(to newValue: Int) {
        // mutate 데이터를 변화시키다. 기존의 데이터값을 변경하는 행위.
        // struct나 class, enum 안에서 선언된 함수를 method라고 부름. 밖에 있으면 그냥 함수
        for index in 0..<players.count{
            players[index].score = newValue
            // 이전에는 함수의 결과가 0으로만 설정 되어있어서 실패?함.. newValue 즉 모든 경우를 커버할 수 있다
            // 넣어볼 함수값 0, 10, 20. 튜토리얼 목표는 리셋이 아니라 이게 잘 돌아가는지 확인하는 법을 아는 것
        }
        // 점수 초기화 하는 for문 작성
    }
    
    
    
}
