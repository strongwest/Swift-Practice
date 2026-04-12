## [Data Modeling] CH1. Custom types and Swift Testing

### Preview
<p align="center"><img src="https://github.com/strongwest/Swift-Practice/blob/main/DataModeling/Preview/1-1.png?raw=true" width="30%" height="auto" /> <img src="https://github.com/strongwest/Swift-Practice/blob/main/DataModeling/Preview/1-2.png?raw=true" width="30%" height="auto" /> <img src="https://github.com/strongwest/Swift-Practice/blob/main/DataModeling/Preview/1-3.png?raw=true" width="30%" height="auto" /></p>

## 1-1. Model data with custom types
https://developer.apple.com/tutorials/develop-in-swift/model-data-with-custom-types

* View 없는 Swift File로 새로운 데이터 타입 만들기(struct)
```swift
struct Player {
    var name: String
    var score: Int
}
```
* Identifiable + UUID
  * UUID(Universally Unique Identifier): 각 인스턴스에 고유 ID 부여. 완전히 고유한 값을 만들어주며 같은 이름의 데이터도 구분 가능.
  * id는 프로퍼티(property), UUID는 데이터 타입(type)
  * Identifiable 프로토콜: Swift에서 객체의 고유성(Identity)을 보장하기 위한 프로토콜. 해당 타입이 'id' 프로퍼티를 통해 구분됨을 SwiftUI에 알리는 역할.
```swift
struct Player: Identifiable {
    let id = UUID()    
    var name: String
    var score: Int
}
```
* Grid/GridRow를 사용해 레이아웃 구성
```swift
Grid {
    GridRow {
```
* Stepper 범위 제한
`Stepper("Score", value: $score, in: 0...20)`


## 1-2. Add functionality with Swift Testing
https://developer.apple.com/tutorials/develop-in-swift/add-functionality-with-swift-testing
