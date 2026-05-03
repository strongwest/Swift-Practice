# [Machine Learning and AI] 14. Recognize text in images: Extract text from images

### Preview

<p><img width="20%" height="auto" alt="Image" src="https://github.com/user-attachments/assets/d1bd789c-b1dc-41ed-8928-6033a694d7ff" />
<img width="20%" height="auto" alt="Image" src="https://github.com/user-attachments/assets/fbd56713-ae9d-46d2-90be-c6b63ad8f2d0" />
<img width="20%" height="auto""alt="Image" src="https://github.com/user-attachments/assets/2c198aa7-1838-4074-a9b4-5e2bde415887" /></p>

---

### import Translation
```swift
func translationPresentation(
    isPresented: Binding<Bool>,
    text: String,
    //attachmentAnchor: PopoverAttachmentAnchor = .rect(.bounds),
    //arrowEdge: Edge = .top,
    //replacementAction: ((String) -> Void)? = nil
) -> some View
```

### Vision ML Framework
- 이미지와 비디오에서 여러 세부사항 식별(텍스트, 얼굴 등)
- 파일이 뷰를 그리고 있지 않아도 사진을 이미지 데이터로 변환하기 위해 import SwitUI 필요
    - `pngData()` : 이미지를 png 데이터 형식으로 복제. `RecognizeTextRequest()`는 image data에서 바로 작동한다.

### RecognizeTextRequest() 
- 이미지 내 텍스트 인식 요청 → `.perform` 으로 요청 수행
- 반환값: 1. 식별된 텍스트 / 2. 이미지에서 텍스트의 위치 / 3. 텍스트값이 정확하다는 신뢰 수준
    
    텍스트 인식이 부정확할 수 있으므로 위치와 신뢰수준이 그를 보조
    
- `RecognizedTextObservation` : 비전 프레임워크를 통해 식별된 텍스트. RecognizeTextRequest가 가능이라고 판단한 텍스트 배열

ex. results = [observation1, observation2]

observation1 = [”Hello”, “Hella”]
observation2 = [”World”, “Wor1d”]

topCandidates(1) = “Hello”, “World”

### async & await
- 함수를 비동기로 실행
    - 에러를 반환하는 경우에는 **async throws**

```swift
init(imageResource: ImageResource) async {
        var request = RecognizeTextRequest() ...
```

- **async로 선언한 함수를 호출**하기 위해 **await**이라는 키워드를 앞에 붙이고 호출
    - **async throws로 선언한 함수를 호출**하기 위해서는 **try await**

```swift
textRecognizer = await TextRecognizer(imageResource: imageResource)
```

### recognitionLevel = .accurate / .fast
인식 모드: 정확 vs 빠름
<p><img width="40%" height="auto" alt="Image" src="https://github.com/user-attachments/assets/f1f76fcc-3661-4a92-a88f-9836061f8379" /></p>

### Shape 프로토콜
A 2D shape that you can use when drawing a view.

`func path(in rect: CGRect) -> Path` 메서드를 통해, 주어진 영역(in) 안에서 `Path`(경로), outline 반환

### NormalizedRect

고정 좌표가 아니라 백분율로 정의된 직사각형. 이미지의 크기에 관계없이 텍스트 경계에 도형 생성 가능

### 로딩창

```swift
if isProcessing { ProgressView() }
```

<p><img width="288" height="125" alt="Image" src="https://github.com/user-attachments/assets/543bb7f7-81db-4bef-be43-5df50a9f7920" /></p>

### ViewModifier 프로토콜
- 커스텀 뷰 수정자를 만들어 재사용 가능한 UI 스타일을 정의하는 핵심 기능
- `body(content: Content)` 메서드로 ‘기존 뷰’ → ‘스타일 적용된 뷰’로 변환하는 구조체 생성

```swift
struct TrailTheme: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            VStack{
                Image(.background)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxHeight: 250, alignment: .top)
                    Spacer()
            }
            content
        }
    }
}

// .frame, .padding 등과 같은 방식으로 .trailTheme 사용 가능
extension View {
    func trailTheme() -> some View {
        modifier(TrailTheme())
    }
}
```
