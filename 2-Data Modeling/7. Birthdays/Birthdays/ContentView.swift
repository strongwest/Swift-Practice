//
//  ContentView.swift
//  Birthdays
//
//  Created by 강서현 on 4/11/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query(sort: \Friend.birthday) private var friends: [Friend]
    // 친구 배열을 State에서 Query로 변환. 쿼리는 SwiftData에서 배열을 요청한다. 고로 내가 임의로 추가한 데이터는 삭제
//    = [
//        Friend(name: "River", birthday: .now),
//        Friend(name: "Zen", birthday: Date(timeIntervalSince1970: 0))
//    ]
    @Environment(\.modelContext) private var context
    // modelContext는 뷰가 모델 컨테이너 내 항목을 가져오고 수정, 삭제할 수 있게 함
    
    @State private var newName = ""
    @State private var newDate = Date.now
    
    var body: some View {
        NavigationStack{
            // 원래 id: .\ 썼는데 이제 swiftData 쓸거니까 없어도됨
            List(friends) { friend in
                HStack {
                    if friend.isBirthdayToday {
                        Image(systemName: "birthday.cake")
                    }
                    Text(friend.name)
                        .bold(friend.isBirthdayToday)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                    // .wide : Jan이나 1 대신 January
                }
            }
            .navigationTitle("Birthdays")
            .toolbarTitleDisplayMode(.inlineLarge)
            .safeAreaInset(edge: .bottom){
                VStack(alignment: .center, spacing: 20) {
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker(selection: $newDate, in: Date.distantPast...Date.now, displayedComponents: .date){
                        // 범위in 과거...지금, 표시할 거: 시간 빼고 날짜만
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }
                    Button("Save"){
                        let newFriend = Friend(name: newName, birthday: newDate)
                        context.insert(newFriend)
                        // 배열에 append 쓰듯이 context는 insert
                        
                        newName = ""
                        newDate = .now
                        // 저장 후 상태 초기화
                    }
                    .bold()
                }
                .padding()
                .background(.bar)
            }
//            .task {
//                context.insert(Friend(name: "River", birthday: .now))
//                context.insert(Friend(name: "Zen", birthday: Date(timeIntervalSince1970: 0)))
//            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
        // inmemory: 데이터 저장
}
