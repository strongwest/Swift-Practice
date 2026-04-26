## [Data Modeling] 6. Custom types and Swift Testing

### Preview
<img width="30%" height="auto" alt="Image" src="https://github.com/user-attachments/assets/d0425a6d-504b-45c4-bdd7-9ab3de8245db" /><img width="30%" height="auto" alt="Image" src="https://github.com/user-attachments/assets/1b80bf8c-6bde-4332-a455-b9b8a6270eda" /> <img width="30%" height="auto" alt="Image" src="https://github.com/user-attachments/assets/4c5db0bb-aa04-4764-bc94-d46b5666c70b" /></p>

## 6-1. Model data with custom types
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


## 6-2. Add functionality with Swift Testing
https://developer.apple.com/tutorials/develop-in-swift/add-functionality-with-swift-testing

* Unit Test: 작성한 메소드, 함수의 기능이 올바르게 작동하는지 확인하기 위해 사용
```swift
import Testing
@testable import ScoreKeeper

struct ScoreKeeperTests {

@Test("Highest score wins")
    func highestScoreWins() { ...
        #expect(winners == [Player(name: "Zen", score: 4)])
    }
```
* mutate: 변화시키다. 특정 메서드 내에서 프로퍼티를 수정해야할 때 사용 'mutating func resetScores(to newValue: Int)'
    * 메서드(method): struct나 class, enum 안에서 선언된 함수. 밖에 있으면 그냥 함수.
* @Previewable: 프리뷰 내에서 @State 선언
```swift
#Preview {
    @Previewable @State var
```
