import SwiftData
import SwiftUI

@Observable
@MainActor
class DataContainer {
    let modelContainer: ModelContainer
    var badgeManager: BadgeManager

    var context: ModelContext {
        modelContainer.mainContext
    }

    init(includeSampleMoments: Bool = false) {
        let schema = Schema([
            Moment.self,
            Badge.self
        ])

        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: includeSampleMoments)

        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            badgeManager = BadgeManager(modelContainer: modelContainer)
            
            try badgeManager.loadBadgesIfNeeded()
            // DataContainer이 만들어질 때마다 뱃지 불러오기
            // 앱이 실행될 때마다 지금 가지고 있는 뱃지 체크해서 중복 방지
            
            if includeSampleMoments {
                try loadSampleMoments()
            }
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    private func loadSampleMoments() throws {
        for moment in Moment.sampleData {
            context.insert(moment)
            try badgeManager.unlockBadges(newMoment: moment)
        }
    }
}

private let sampleContainer = DataContainer(includeSampleMoments: true)

extension View {
    func sampleDataContainer() -> some View {
        self
            .environment(sampleContainer)
            .modelContainer(sampleContainer.modelContainer)
    }
}
