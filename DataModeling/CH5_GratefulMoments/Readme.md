# [App Development] 10. Views and data storage / 11. User experience features
### Preview
<p><img src="https://github.com/strongwest/Swift-Practice/blob/main/DataModeling/Preview/5-1.png?raw=true" width="15%" height="auto" /> <img src="https://github.com/strongwest/Swift-Practice/blob/main/DataModeling/Preview/5-2.png?raw=true" width="15%" height="auto" /><img src="https://github.com/strongwest/Swift-Practice/blob/main/DataModeling/Preview/5-3.png?raw=true" width="15%" height="auto" /><img src="https://github.com/strongwest/Swift-Practice/blob/main/DataModeling/Preview/5-4.png?raw=true" width="15%" height="auto" /><img src="https://github.com/strongwest/Swift-Practice/blob/main/DataModeling/Preview/5-5.png?raw=true" width="15%" height="auto" /></p>


## 10-1. Collect, model, and store data
### 폴더 정리

- Custom Views: 복잡한/특정한 UI
- Logic: 데이터 모델로 작동하는 코드
- Models: 데이터 타입
- Tabs: 두 개의 메인 뷰

### Multiline text field

```swift
TextField("Log your small wins", text: $note, axis: .vertical)
//axis: .vertical 콘텐츠에 확장되는 텍스트 필드 생성
.lineLimit(5)
```

### import PhotosUI

- 포토 라이브러리 접근 가능

### onChange / guard let

- 예외처리. 조건이 충족되지 않을 때 코드의 실행을 중단하고 특정 블록을 종료
- 옵셔널을 안전하게 풀고 nil이면 즉시 탈출하기 위해 → guard는 자신을 감싸는 코드 블록이 있어야 하며, else에 return, break, Throw, continue 등 '제어문 전환 명령어'가 필요

```swift
.onChange(of: value, perform: { newValue in
    // 'value'가 변경되었을 때 실행할 코드
})
```

```swift
.onChange(of: newImage) { 
		guard let newImage else { return }
})
```

### 이미지 가져오기

```swift
Group {
                if let imageData, let uiImage = UIImage(data: imageData){
                    // imageData는 바이트 데이터이므로 화면에 그릴 이미지 객체로 만들기 위해 UI Image로 변환
                    // UIImage는 UI kit에서 이미지를 그리는 방식. swiftUI로 옮기기 위해 Image()로 감싸주기
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
```

두가지를 동시에 만족할 때 Image 표시

- if let imageData 이미지 데이터가 있으면
- let uiImage = UIImage(data: imageData) 이미지 데이터를 실제 이미지로 바꿀 수 있으면

### SwiftData

Import SwiftData + @Model: 타입을 저장하고 조회. 초기화자 필요

💡 https://mini-min-dev.tistory.com/329

<aside>
  
1. Schema: @Model을 붙여 Class로 정의
2. 앱의 진입점 @main에 모델 컨테이너 설정
    1. ModelConfiguration으로 커스텀 속성 설정
3. 모델 컨텍스트를 활용해 CUD
4. 쿼리로 R

</aside>

### 다시보기

Marking the `DataContainer` class with `@MainActor` ensures that any interactions with the container from your views happen on the main thread, which is required for UI updates.

The `@Observable` macro tells SwiftUI to watch your `DataContainer` for changes. You add the container to the environment so the model container and any future properties on `DataContainer` are available through the view hierarchy.

### isShowingCancleConfirmation

취소를 누를 때 다시 한 번 확인하게 하는 안전 장치(destructive action 예방)

위치: 이벤트(버튼) 안

```swift
isShowingCancleConfirmation = true
                    }
                    .confirmationDialog("Discard Moment", isPresented: $isShowingCancleConfirmation){
                        Button("DisCardMoment", role: .destructive) {
                        dismiss()
                        }
                        }
```

### <확인문제>

1. **loadTransferable**
    
    PhotosPicker가 선택한 사진을 불러오게 하기
    

```swift
imageData = try? await newImage.loadTransferable(type: Data.self)
```

2. **Optional이 있을 때 flatMap**
    
    Transforms the value if the value is non-optional.


    
    `flatMap` transforms the value inside an `Optional` and flattens nested `Optional` values.
    
4. **View를 body 밖에서 만들면 읽기 쉽고 좋다.**

## 10-2. Use a Custom Layout View
### 모달 띄우기

```swift
@State private var showCreateMoment: Bool = false
..
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
```

### 빈 화면 만들기

```swift
.overlay{
                if moments.isEmpty {
                    ContentUnavailableView {
                        Label("No moments yet!", systemImage: "exclamationmark.circle.fill")
                    } description: {
                        Text("Post a note or photo to start filling this space with gratitude.")
                    }
                }
            }
```

### View Builder

*클로저로부터 뷰를 만들어내는 커스텀 파라미터 어트리뷰트*

뷰 빌더를 통해 한 개 이상의 뷰를 만들어낼 수 있음. VStack, HStack 등도 같은 원리로 작동한다

```swift
// VStack의 initializer
@inlinable public init(
 alignment: HorizontalAlignment = .center,
 spacing: CGFloat? = nil, 
 @ViewBuilder content: () -> Content
)
```

### Mask

[`Mask`](https://developer.apple.com/documentation/swiftui/view/mask(alignment:_:)) is a handy tool when using irregular shapes or displaying content that exceeds your display area.

불규칙적인 도형을 사용하거나 영역을 초과하는 콘텐츠를 클리핑 할 때 좋음

### Scroll Transition

```swift
            .scrollTransition { content, phase in
                content
                    .opacity(phase.isIdentity ? 1: 0)
                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
            }
            // 우와 스크롤 할때마다 크기가 바뀐다
          
```

### 11-1. Create an algorithm for badges 

### enum과 switch

- enum: 경우의 수를 만듦 → case
- swith: 경우의 수를 처리
    - 모든 경우의 수case를 처리해야 함

```swift
var color: Color {
        switch self {
        case .firstEntry:
            return .ember
        case .fiveStars:
            return .ruby
```

### FetchDescriptor

- 데이터를 어떻게 가져올지 설명하는 조건서
- 가져올 데이터의 유형을 정의하고 필터링, 정렬, 결과의 수를 제한

```swift
 func loadBadgesIfNeeded() throws {
        let context = modelContainer.mainContext
        var fetchDescriptor = FetchDescriptor<Badge>()
        fetchDescriptor.fetchLimit = 1
        let existingBadges = try context.fetch(fetchDescriptor)
    }
```

```swift
func unlockBadges(newMoment: Moment) throws {
        let context = modelContainer.mainContext
        let moments = try context.fetch(FetchDescriptor<Moment>())
        let lockedBadges = try context.fetch(FetchDescriptor<Badge>(predicate: #Predicate { $0.timestamp == nil }))
```

- `context.fetch(…)` : context = ModelContext, fetch = 조회
- `FetchDescriptor<Badge>` : Badge 타입을 가져오자
- `predicate` : 조건

→ 상수 `lockedBadges` : ModelContext에서 타임스탬프가 없는nil 뱃지들을 모두 가져온 것

### rawValue

열거형enum 데이터에서 각 케이스에 맵핑되는 기초 데이터(문자열, 정수 등 순서). 케이스를 상숫값으로 식별할 때 사용(순서 정렬)

```swift
lockedBadges.sorted {
            $0.details.rawValue < $1.details.rawValue
        }
```

### 스크롤

`.scrollClipDisabled()` : 잘림 방지
`.scrollIndicators(.hidden)` : 스크롤바 숨기기

### Map

- map: 배열의 모든 요소 변환
- compactMap: 배열의 모든 요소 변환 + 옵셔널(nil) 제거
```swift
let daysAgoArray = moments
            .reversed() // 최신 -> 과거 순서
            .map(\.timestamp) // 타임스탬프만 꺼내기 [Moment] -> [Date]
            .map { calendar.dateComponents([.day], from: $0, to: endOfToday) } // dateComponents 날짜 계산하는 파라미터
                // 결과타임 [Date] -> [DateComponents]
            .compactMap {$0.day} // day 값만 꺼내고 nil 제거
                // 결과 타입 -> [Int]
```
