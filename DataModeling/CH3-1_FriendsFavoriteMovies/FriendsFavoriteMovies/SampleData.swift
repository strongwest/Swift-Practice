//
//  SampleData.swift
//  FriendsFavoriteMovies
//
//  Created by 강서현 on 4/12/26.
//

import Foundation
import SwiftData

@MainActor
// 이 class의 코드가 mainActor에서 실행되어야 함 선언
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext{
        modelContainer.mainContext
        // mainContext에 접근하게 하는 actor.. 사실 잘 모르겠음 이 context의 작동방식을
    }
    
    var friend: Friend {
        Friend.sampleData.first!
        // ! : 강제 언래핑 연산자. 값이 없으면 종료
    }
    
    var movie: Movie {
        Movie.sampleData.first!
    }
    
    private init() {
        let schema = Schema([
            Friend.self,
            Movie.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        // configuration: 구성
        // 데이터 영구저장 X, 새로고침 O
        do{
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            insertSampleData()
            // 무조건 오류 없으므로 try 필요 없음
            
            try context.save()
        } catch {
            fatalError("Could not creat ModelContainer: \(error)")
            // fatal error: 즉시 중단
        }
        // try: 오류가 발생할 수 있는 아이를 사용할 거라고 예고
        // do catch: do 에서 발생한 오류를 catch로 처리
    }
    // 이니셜라이저 대신 컨테이너 생성
    
    private func insertSampleData(){
        for friend in Friend.sampleData{
            context.insert(friend)
        }
        for movie in Movie.sampleData{
            context.insert(movie)
        }
    }
}
