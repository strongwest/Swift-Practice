# [App Development] 12. App refinement
## 12-1. Add inclusive features

### 다크모드

`.preferredColorScheme(.dark)`

<img width="30%" height="auto" alt="Image" src="https://github.com/user-attachments/assets/c701e149-ba0a-4b83-b70f-6b5aa8f8928f" />

### **Adapt to Dynamic Type**

**Dynamic Type**: 사용자가 기기 설정에서 선택한 텍스트 크기(작게, 기본, 크게 등)에 맞춰 앱의 폰트 크기가 실시간으로 자동으로 조절되는 기능

- 접근성과 가독성을 위해 필수적으로 지원해야 하는 기능. 단순히 글자만 커지는 게 아니라 레이아웃도 유연하게 대응하도록 설계.
- 설계시 고려해야할 점: 폰트가 커졌을 때 중요한 텍스트가 짤리지 않는지? 긴 글이 레이아웃에 어긋나지 않는지?

<img width="40%" height="auto" alt="Image" src="https://github.com/user-attachments/assets/4724c7a8-d127-40a8-b6f8-cce02143e51b" />

- `.minimumScaleFactor( )` : 요소 안에서 텍스트 짤림 방지
- `.fixedSize()` : 고정된 크기를 무시하고 텍스트 크기에 맞게 늘어나거나 줄어듦 = 가장 이상적인 뷰의 크기로 적용하는 모디파이어
- `.scrollBounceBehavior(.basedOnSize)` : 스크롤 가능한 뷰가 끝까지 스크롤 되었을 때 튀어오르는 방식
- `.dynamicTypeSize(...DynamicTypeSize.xxxLarge)` : 폰트 최대 크기 지정

### 문자열 Localization - AttributedString

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

- `daysAgo`: 오늘 기준으로 n일 전
    
    **→ 연속된 날짜 streak 계산 로직**
    
    ```swift
    var streak = 0
            for daysAgo in daysAgoArray {
                if daysAgo == streak {
                    print("Streak already here. Don't increase the streak.")
                    continue
                } else if daysAgo == streak + 1 {
                    print("A moment exists the day after the current streak")
                    streak += 1
                    print("Increased streak to \(streak)")
                } else{
                    print("Streak of \(streak) broken with daysAgo \(daysAgo)")
                    break
                }
            }
            return streak
    ```
    
### Bug report

버그 해결을 위해서는…

버그를 재현하고(버그 레포트에 쓰인대로 테스트)

올바른 동작을 찾아내고(다양한 케이스로 테스트)

앱 코드를 수정

단위 테스트는 디버깅이 버깅을 발생시키는 ‘회귀 오류’를 방지하는 데 도움이 된다.

- *기존 코드: 어제부터 며칠 연속인가?(연속된 추가 일수)*
- *↔ 테스트 예상 답변: 오늘을 포함해서 며칠 연속인가?(오늘 포함 전체 연속 일수)*
