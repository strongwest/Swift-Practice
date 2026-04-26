//
//  MomentDetailView.swift
//  GratefulMoments
//
//  Created by 강서현 on 4/20/26.
//

import SwiftUI
import SwiftData

struct MomentDetailView: View {
    var moment: Moment
    @State private var showConfirmation = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer
    
    var body: some View {
        ScrollView{
            contentStack
        }
        .navigationTitle(moment.title)
        .toolbar{
            ToolbarItem(placement: .destructiveAction){
                Button {
                    showConfirmation = true
                } label: {
                    Image(systemName: "trash")
                }
                .confirmationDialog("Delete Moment", isPresented: $showConfirmation) {
                    Button("Delete Moment", role: .destructive) {
                        dataContainer.context.delete(moment)
                        // 데이터 삭제
                        try? dataContainer.context.save()
                        // 삭제된 상태를 반영
                        dismiss()
                    }
                } message: {
                    Text("The moment will be permanently deleted. Earned badges won't be removed.")
                    
                }
            }
        }
    }
    
    // MARK: - contentStack
    private var contentStack: some View {
        VStack(alignment: .leading){
            Text(moment.timestamp, style: .date)
                .font(.subheadline)
            if !moment.note.isEmpty {
                Text(moment.note)
                    .textSelection(.enabled)
                    // .textSelection: 텍스트 복사
            }
            if let image = moment.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
}

#Preview {
    NavigationStack {
        MomentDetailView(moment: .imageSample)
            .sampleDataContainer()
    }
}
