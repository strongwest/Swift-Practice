//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by 강서현 on 4/11/26.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
            // container: view가 모델(Friend) 유형을 참조하게 함
        }
    }
}
