//
//  GratefulMomentsApp.swift
//  GratefulMoments
//
//  Created by 강서현 on 4/19/26.
//

import SwiftUI
import SwiftData

@main
struct GratefulMomentsApp: App {
    
    let dataContainer = DataContainer()
    // 샘플 없는 컨테이너 생성
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(dataContainer.modelContainer)
        // connect ModelContainer
    }
}
