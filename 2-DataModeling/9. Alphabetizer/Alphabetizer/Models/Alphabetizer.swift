//
//  Alphabetizer.swift
//  Alphabetizer
//
//  Created by 강서현 on 4/18/26.
//

import Foundation
import Observation

@Observable
// 클래스에 새로운 기능을 추가하는 매크로
class Alphabetizer {
    private let tileCount = 3
    private var vocab: Vocabulary
    // 1-1. 값이 없는 상태로 선언된 저장 프로퍼티. 모든 저장 프로퍼티는 초기화되기 전에는 사용될 수 없다.
    var tiles = [Tile]()
    var score = 0
    var message: Message = .instructions
    
    init(vocab: Vocabulary = .landAnimals) {
        self.vocab = vocab
        // 1-2. 그래서 객체를 초기화하는 init이 필요함. 객체를 만들 때 vocab이라는 값을 넣어줘라~ 라는 말. 만약 값을 안 넣었다면 그 기본값은 .oceanAnimals라고 하겠다~는 말.
        startNewGame()
        
    }

    /// Chekcs if tiles are a alphabetical order 알파벳이 순서대로 정렬되었는지 확인
    // ///는 문서 주석. 옵션 눌러서 확인 가능

    // Check if the tiles are in alphabetical order
    func submit() {
        // Check if the tiles are alphbetized
        let userSortedTiles = tiles.sorted {
            $0.position.x < $1.position.x
            // 이게뭔데 ㅁㅊ ㅠㅠㅠㅠㅠㅠㅠ
            // $0: 첫번째, $1: 두번쨰.. x는 그.. 가로 위치를 나타내니까 타일을 왼쪽->오른쪽 순서로 정렬할 거고 -> 사용자가 배치한 순서를 읽음
            // 솔직히 아직 모르겠다
        }
        
        let alphbeticallySortedTiles = tiles.sorted {
            $0.word.lexicographicallyPrecedes($1.word)
        }
        // 렉시코어쩌구 = 사전적 순서, 알파베티컬 순서
        
        // Alternates true and false
        let isAlphabetized = userSortedTiles == alphbeticallySortedTiles
        
        // If alphaetized, increment the score
        if isAlphabetized {
            score += 1
        }
        
        // Update the message to win or lose
        message = isAlphabetized ? .youWin : .tryAgain
        
        // Flip over correct tiles
        for (tile, correctTile) in zip(userSortedTiles, alphbeticallySortedTiles) {
            let tileIsAlphabetized = tile == correctTile
            tile.flipped = tileIsAlphabetized
        }
        
        // Delay 2 seconds
        Task{ @MainActor in
            try await Task.sleep(for: .seconds(2))
            
            // If alphabetized, generate new tiles
            if isAlphabetized {
                startNewGame()
            }
            
            // Flip tiles back to words
            for tile in tiles {
                tile.flipped = false
            }
            
            // Display instructions
            message = .instructions
        }
    }

    // MARK: private implementation 이 아래로는 이 파일 내에서만 호출.
    /// Updates `tiles` with a new set of unalphabetized words
    private func startNewGame(){
        let newWords = vocab.selectRandomWords(count: tileCount)
        if tiles.isEmpty {
            for word in newWords {
                tiles.append(Tile(word: word))
            }
        } else {
            // 기존 타일에 새 단어를 할당
            for (tile, word) in zip(tiles, newWords) {
                tile.word = word
            }
        }
    }
}
