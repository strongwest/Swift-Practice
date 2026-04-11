//
//  BirthdaysAp.swift
//  OnboardingFlow
//
//  Created by 강서현 on 3/31/26.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}

//#Preview {
//    BirthdaysApp()
//}
