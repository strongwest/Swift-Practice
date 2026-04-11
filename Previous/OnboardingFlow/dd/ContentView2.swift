import SwiftUI
import SwiftData

struct ContentView2: View {
    @Query(sort: \Friend.birthday) private var friends: [Friend]
    @Environment(\.modelContext) private var context
    
    @State private var newName = ""
    @State private var newDate = Date.now
    
    
    var body: some View {
        NavigationStack {
            List(friends) { friend in
                HStack {
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                }
            }
            .navigationTitle("Birthdays")
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .center, spacing: 20) {
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker(selection: $newDate, in: Date.distantPast...Date.now, displayedComponents: .date) {
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newDate)
                        context.insert(newFriend)
                        
                        newName = ""
                        newDate = .now //추가 후 리셋
                    }
                    .bold()
                }
                .padding()
                                .background(.bar)
            }
//            .task {
//                            context.insert(Friend(name: "Elton Lin", birthday: .now))
//                            context.insert(Friend(name: "Jenny Court", birthday: Date(timeIntervalSince1970: 0)))
//                        }
            
        }
    }
}

//
#Preview {
    ContentView2()
}
//
//
//import SwiftUI
//import SwiftData
//
//
//struct ContentView2: View {
//    @Query private var friends: [Friend]
//    @Environment(\.modelContext) private var context
//
//
//    @State private var newName = ""
//    @State private var newDate = Date.now
//
//
//    var body: some View {
//        NavigationStack {
//            List(friends) { friend in
//                HStack {
//                    Text(friend.name)
//                    Spacer()
//                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
//                }
//            }
//            .navigationTitle("Birthdays")
//            .safeAreaInset(edge: .bottom) {
//                VStack(alignment: .center, spacing: 20) {
//                    Text("New Birthday")
//                        .font(.headline)
//                    DatePicker(selection: $newDate, in: Date.distantPast...Date.now, displayedComponents: .date) {
//                        TextField("Name", text: $newName)
//                            .textFieldStyle(.roundedBorder)
//                    }
//                    Button("Save") {
//                        let newFriend = Friend(name: newName, birthday: newDate)
//                        context.insert(newFriend)
//
//
//                        newName = ""
//                        newDate = .now
//                    }
//                    .bold()
//                }
//                .padding()
//                .background(.bar)
//            }
//            .task {
//                context.insert(Friend(name: "Elton Lin", birthday: .now))
//                context.insert(Friend(name: "Jenny Court", birthday: Date(timeIntervalSince1970: 0)))
//            }
//        }
//    }
//}
//
//
//#Preview {
//    ContentView2()
//        .modelContainer(for: Friend.self, inMemory: true)
//}
