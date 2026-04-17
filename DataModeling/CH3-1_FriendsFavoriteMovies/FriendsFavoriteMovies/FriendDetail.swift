//
//  FriendDetail.swift
//  FriendsFavoriteMovies
//
//  Created by 강서현 on 4/12/26.
//

import SwiftUI
import SwiftData

struct FriendDetail: View {
    @Bindable var friend: Friend
    // Bindable: 모든 클래스가 관찰, 추적 가능
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    // 환경에 dismiss 속성 추가
    @Environment(\.modelContext) private var context
    
    init(friend: Friend, isNew: Bool = false) {
        self.friend = friend
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            // 내가 찾던게 바로 이거야 Form
            TextField("Name", text: $friend.name)
                .autocorrectionDisabled()
        }
        .navigationTitle(isNew ? "New Friend" : "Friend")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            // confirmationAction: 의미 기반 위치. 관례.
            if isNew {
                ToolbarItem(placement: .confirmationAction){
                    Button("Save") {
                        dismiss()
                    }
                }
            ToolbarItem(placement: .cancellationAction){
                Button("Cancel"){
                    context.delete(friend)
                    dismiss()
                }
            }
        }
        }
    }
}

#Preview("New Friend") {
    NavigationStack{
        FriendDetail(friend: SampleData.shared.friend, isNew: true)
    }
}
