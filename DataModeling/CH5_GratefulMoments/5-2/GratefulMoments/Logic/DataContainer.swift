//
//  DataContainer.swift
//  GratefulMoments
//
//  Created by 강서현 on 4/19/26.
//

import Foundation
import SwiftData
import SwiftUI
import Observation

@Observable
@MainActor
class DataContainer {
    let modelContainer: ModelContainer
    // 한번만 만들면 되는 저장소 설립
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    // includeSampleMoments: 샘플 데이터 포함/미포함, 프리뷰는 포함true/실제 앱은 미포함false하도록
    // init에서 샘플 데이터를 넣을지 말지 조건적으로 결정하는 부분
    init(includeSampleMoments: Bool = false){
        let schema = Schema([
            Moment.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: includeSampleMoments)
        
        do {

            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            loadSampleMoments()
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }

    }
    
    // 샘플 데이터를 로드하는 함수 생성
    func loadSampleMoments() {
        for moment in Moment.sampleData {
            context.insert(moment)
        }
        try? context.save()
    }
}
