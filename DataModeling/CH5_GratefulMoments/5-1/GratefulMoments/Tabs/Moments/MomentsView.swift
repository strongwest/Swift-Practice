//
//  MomentsView.swift
//  GratefulMoments
//
//  Created by 강서현 on 4/20/26.
//

import SwiftUI
import SwiftData

struct MomentsView: View {
    @Query(sort: \Moment.timestamp) var moments: [Moment]
    
    var body: some View {
        NavigationStack{
            ScrollView {
                pathItems
                    .frame(maxWidth: .infinity)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction){
                    Button {
                        
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Grateful Moments")
        }
    }
    
    private var pathItems: some View {
            ForEach(moments) { moment in
                Text(moment.title)
            }
    }
    
}

#Preview() {
    MomentsView()
        .sampleDataContainer()
}

#Preview("No moments") {
    MomentsView()
        .modelContainer(for: [Moment.self])
}
