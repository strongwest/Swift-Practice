## [Data Modeling] CH5. Views and data storage
### Preview
..

### 5-1. Collect, model, and store data
### 폴더 정리

- Custom Views: 복잡한/특정한 UI
- Logic: 데이터 모델로 작동하는 코드
- Models: 데이터 타입
- Tabs: 두 개의 메인 뷰

### Multiline text field

```jsx
TextField("Log your small wins", text: $note, axis: .vertical)
//axis: .vertical 콘텐츠에 확장되는 텍스트 필드 생성
.lineLimit(5)
```

### import PhotosUI

- 포토 라이브러리 접근 가능

### onChange / guard let

- 예외처리. 조건이 충족되지 않을 때 코드의 실행을 중단하고 특정 블록을 종료
- 옵셔널을 안전하게 풀고 nil이면 즉시 탈출하기 위해 → guard는 자신을 감싸는 코드 블록이 있어야 하며, else에 return, break, Throw, continue 등 '제어문 전환 명령어'가 필요

```jsx
.onChange(of: value, perform: { newValue in
    // 'value'가 변경되었을 때 실행할 코드
})
```

```jsx
.onChange(of: newImage) { 
		guard let newImage else { return }
})
```

### 이미지 가져오기

```jsx
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

```jsx
isShowingCancleConfirmation = true
                    }
                    .confirmationDialog("Discard Moment", isPresented: $isShowingCancleConfirmation){
                        Button("DisCardMoment", role: .destructive) {
                        dismiss()
                        }
                        }
```

### 확인문제

1. **loadTransferable**
    
    PhotosPicker가 선택한 사진을 불러오게 하기
    

```jsx
imageData = try? await newImage.loadTransferable(type: Data.self)
```

2. **Optional이 있을 때 flatMap**
    
    Transforms the value if the value is non-optional.
    
    `flatMap` transforms the value inside an `Optional` and flattens nested `Optional` values.
    
3. **View를 body 밖에서 만들면 읽기 쉽고 좋다.**
