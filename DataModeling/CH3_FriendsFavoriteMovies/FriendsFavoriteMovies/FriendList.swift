//
//  FriendList.swift
//  FriendsFavoriteMovies
//
//  Created by 강서현 on 4/12/26.
//

import SwiftUI
import SwiftData

struct FriendList: View {
    @Query(sort: \Friend.name) private var friends: [Friend]
    @Environment(\.modelContext) private var context
    @State private var newFriend: Friend?
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(friends) { friend in
                    NavigationLink(friend.name){
                        FriendDetail(friend: friend)
                    }
                }
                .onDelete(perform: deleteFriends(indexes:))
            }
            .navigationTitle("Friends")
            .toolbar {
                ToolbarItem {
                    Button("Add friend", systemImage: "plus", action: addFriend)
                }
                ToolbarItem(placement: .topBarTrailing){
                    EditButton()
                }
            }
            .sheet(item: $newFriend) { friend in
                NavigationStack{
                    FriendDetail(friend: friend, isNew: true)
                }
                .interactiveDismissDisabled()
            }
            
        } detail: {
            // detail은 splitview에서 지원
            Text("Select a friend")
                .navigationTitle("Friend")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func addFriend() {
        let newFriend = Friend(name: "")
        context.insert(newFriend)
        self.newFriend = newFriend
    }
    
    private func deleteFriends(indexes: IndexSet) {
        // IndexSet: 여러 개의 index를 담는 집합
        for index in indexes{
            context.delete(friends[index])
        }
    }
    
}
    
    #Preview {
        FriendList()
            .modelContainer(SampleData.shared.modelContainer)
    }
