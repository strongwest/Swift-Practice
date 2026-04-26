//
//  MomentsView.swift
//  GratefulMoments
//
//  Created by 강서현 on 4/20/26.
//

import SwiftUI
import SwiftData

struct MomentsView: View {
    @Query(sort: \Moment.timestamp) private var moments: [Moment]
    @State private var showCreateMoment: Bool = false
    
    static let offsetAmount: CGFloat = 70.0
    
    var body: some View {
        NavigationStack{
            ScrollView {
                pathItems
                    .frame(maxWidth: .infinity)
            }
            .overlay{
                if moments.isEmpty {
                    ContentUnavailableView {
                        Label("No moments yet!", systemImage: "exclamationmark.circle.fill")
                    } description: {
                        Text("Post a note or photo to start filling this space with gratitude.")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showCreateMoment = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showCreateMoment) {
                        MomentEntryView()
                    }
                }
            }
            .defaultScrollAnchor(.bottom, for: .initialOffset)
            .defaultScrollAnchor(.bottom, for: .sizeChanges)
            .defaultScrollAnchor(.top, for: .alignment)
            .navigationTitle("Grateful Moments")
        }
    }
    
    // 재사용하지 않아도 되는 View는 같은 파일 안에 만들어도 무방
    private var pathItems: some View{
        ForEach(moments.enumerated(), id: \.0) { index, moment in
            NavigationLink {
                MomentDetailView(moment: moment)
            } label: {
                if moment == moments.last {
                    MomentHexagonView(moment: moment, layout: .large)
                } else {
                    MomentHexagonView(moment: moment)
                        .offset(x: sin(Double(index) * .pi / 2) * Self.offsetAmount)
                }
            }
            .scrollTransition { content, phase in
                content
                    .opacity(phase.isIdentity ? 1: 0)
                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
            }
            // 우와 스크롤 할때마다 크기가 바뀐다
        }
    }
}

#Preview {
    MomentsView()
        .sampleDataContainer()
}

#Preview("No moments") {
    MomentsView()
        .modelContainer(for: [Moment.self])
        .environment(DataContainer())
}
