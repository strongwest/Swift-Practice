# [Machine Learning and AI] 13. Natural language

### Preview


## 13-1. Analyze sentiment in text

### NLTagger

텍스트를 쪼개고 의미를 붙여주는 Swift 기본 NLP 도구 ****in Natural Language framework

→ 품사 분석 (명사, 동사 등), 개체 인식 (사람 이름, 장소), 언어 감지, 토큰 분리 (단어 쪼개기)

```swift
class Scorer {
    let tagger = NLTagger(tagSchemes: [.sentimentScore])
}
```

`tagSchemes` : 어떤 기준으로 텍스트를 분석할지 선택

`.sentimentScore` : 문장의 감정을 -1~1로 숫자화

### enumerateTags

using block 파라미터는 클로저이므로 밖으로 뺄 수 있음

```swift
func enumerateTags(
    in range: Range<String.Index>,
    unit: NLTokenUnit,
    scheme: NLTagScheme,
    options: NLTagger.Options = [],
    using block: (NLTag?, Range<String.Index>) -> Bool
)
```

### @FocusState

TextField에서 포커스를 변경/제거하거나 키보드를 해제할 때 사용

```swift
Button("Done"){
                    guard !responseText.isEmpty else { return }
                    saveResponse(text: responseText)
                    responseText = ""
                    textFieldIsFocused = false
                }
```

→ Done을 누르면 자동으로 키보드 해제

TextField가 선택되면 자동으로 textFieldIsFocused = true

### **import** Charts

```swift
Chart(responses) { response in
            SectorMark(angle: .value("Type", 1), angularInset: 2)
        }

init(angle:innerRadius:outerRadius:angularInset:)
angle: PlottableValue<some Plottable>,
    innerRadius: MarkDimension = .automatic,
    outerRadius: MarkDimension = .automatic,
    angularInset: CGFloat? = nil
```

**SectorMark**

- angle: 데이터값의 각도(비율) 결정. 숫자를 넣으면 자동으로 비율 계산됨.
- innerRadius: 도넛 안쪽 크기. 기본은 꽉찬 파이, 값이 커질수록 도넛 모양
- outerRadius: 전체 크기. 기본은 차트 영역에 맞게 자동 .ratio로 크기 조절
- angularInset: 조각 사이의 간격. 데이터 개수만큼 쪼개짐을 확인 가능

**Plottable 프로토콜**

- 차트(막대, 선, 점 등)에 표시될 수 있는 데이터 타입을 정의
- 기본 지원 타입: `Double`, `Int`, `String`, `Date`, `Decimal` 등은 즉시 사용 가능

```swift
enum Sentiment: String, Plottable {
    case positive
    case negative
    case moderate
```

| `.foregroundStyle(by:)` | 어떤 기준으로 색을 나눌지(시스템 기본 팔레트) |
| --- | --- |
| `.chartForegroundStyleScale` | 실제로 무슨 색을 사용할지 |

```swift
init(responses: [Response]){
        self.responses = responses.sorted { $0.score < $1.score}
    }
    // 점수별로 소팅
```

### Geometry Reader

A container view that defines its content as a function of its own size and coordinate space

부모 레이아웃에 따라 이상적인 사이즈 반환

### ChartProxy

```swift
.chartBackground{ chartProxy in
            GeometryReader { geometry in
                if let anchor = chartProxy.plotFrame {
                    let frame = geometry[anchor]
                    Image(systemName: "figure.hiking")
                        .position(x: frame.midX, y: frame.midY)
                }
            }
        }
```

- chartProxy: 차트의 레이아웃 정보(x,y값)에 접근
- plot: 차트 내부 영역
- plotFrame: 차트 안에서 실제로 그래프가 그려지는 영역, plot 영역의 위치정보
    - 축 /  레이블 / 그래프
- anchor: 위치 참조값 → **geometry [anchor]** 실제 좌표

### <확인문제>

1. `NLTagger` automatically analyzes all text provided to it. 

➡️ ❌ : NLTagger는 지정된 범위를 분석. `let range = text.startIndex..<text.endIndex`

1. **NLTagger 단위 분석**
    
    개별 문장을 동시에 분석할 수 있는 함수 **`enumerateTags`**
    
    - **텍스트 → 문장의 범위**(range) **지정 → 문장 분리**(`.unit: .sentence`) **→ enumerateTags로 개별 분석**
    
    ```swift
    enumerateTags(in: range, unit: .sentence, ...)
    ```
    
2. **GeometryReader**
    
    뷰 컨테이너의 레이아웃 데이터를 실시간으로 해석. 동일한 코드로 여러 화면 크기에 상대적으로 대응한다.
