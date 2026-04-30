# [App Development] 12. App refinement
### Preview
<p><img width="30%" height="auto" alt="Image" src="https://github.com/user-attachments/assets/c701e149-ba0a-4b83-b70f-6b5aa8f8928f" /><img width="30%" height="auto" alt="Image" src="https://github.com/user-attachments/assets/4724c7a8-d127-40a8-b6f8-cce02143e51b" /></p>

## 12-1. Add inclusive features

### 다크모드

`.preferredColorScheme(.dark)`

![스크린샷 2026-04-30 오전 11.22.53.png](attachment:4b685386-8d95-45a8-a1ca-55b36d4e28a1:스크린샷_2026-04-30_오전_11.22.53.png)

### **Adapt to Dynamic Type**

**Dynamic Type**: 사용자가 기기 설정에서 선택한 텍스트 크기(작게, 기본, 크게 등)에 맞춰 앱의 폰트 크기가 실시간으로 자동으로 조절되는 기능

- 접근성과 가독성을 위해 필수적으로 지원해야 하는 기능. 단순히 글자만 커지는 게 아니라 레이아웃도 유연하게 대응하도록 설계.
- 설계시 고려해야할 점: 폰트가 커졌을 때 중요한 텍스트가 짤리지 않는지? 긴 글이 레이아웃에 어긋나지 않는지?

![스크린샷 2026-04-30 오전 11.23.58.png](attachment:bdee6ec5-136d-4ceb-9ff0-377f150bea41:스크린샷_2026-04-30_오전_11.23.58.png)

- `.minimumScaleFactor( )` : 요소 안에서 텍스트 짤림 방지
- `.fixedSize()` : 고정된 크기를 무시하고 텍스트 크기에 맞게 늘어나거나 줄어듦 = 가장 이상적인 뷰의 크기로 적용하는 모디파이어
- `.scrollBounceBehavior(.basedOnSize)` : 스크롤 가능한 뷰가 끝까지 스크롤 되었을 때 튀어오르는 방식
- `.dynamicTypeSize(...DynamicTypeSize.xxxLarge)` : 폰트 최대 크기 지정

### **문자열 Localization**

### AttributedString

각 글자에 attributes(크기, 색상, 굵기 등)를 가지고 있는 String

```swift
var attributedText: AttributedString {
            var attributedString = AttributedString(localized: "^[\(numberOfDays) \nDays](inflect: true)")
            // \n 문단 띄어쓰기
            return attributedString
        }
```

`^[ ... ](inflect: true)`

- `[…]` : 변형 대상
- `(inflect: true)` : 숫자에 맞게 복수형 자동 처리

### **Locale**

사용자가 설정한 언어에 유연하게 대응

Information about linguistic, cultural, and technological conventions for use in formatting data for presentation.

아래의 경우 `formatted`로 날짜 형식을 지정했기 때문에 스페인어es에서도 형식이 바뀌지 않음

```swift
Text(moment.timestamp.formatted(
        .dateTime
        .month(.abbreviated).day()
        ))
```

locale 추가하여 로컬라이징 → 스페인 날짜 형식으로 바뀜

## 12-2. Investigate and fix a bug
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

[`Mask`](https://developer.apple.com/documentation/swiftui/view/mask(alignment:_:)) is a handy tool when using irregular shapes or displaying content that exceeds your display area.

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
