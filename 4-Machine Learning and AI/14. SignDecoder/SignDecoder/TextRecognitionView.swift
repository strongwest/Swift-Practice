//
//  TextRecognitionView.swift
//  SignDecoder
//
//  Created by 강서현 on 5/3/26.
//

import SwiftUI
import Vision

struct TextRecognitionView: View {
    let imageResource: ImageResource
    let boundingColor = Color(red: 1.00, green: 0.00, blue: 0.85)
    @State private var textRecognizer: TextRecognizer?
    
    var body: some View {
        VStack {
            Image(imageResource)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .task {
                    textRecognizer = await TextRecognizer(imageResource: imageResource)
                }
                .overlay {
                    if let observations = textRecognizer?.observations {
                        
                        ForEach(observations, id: \.uuid) { observation in
                            BoundsRect(normalizedRect: observation.boundingBox)
                                .stroke(boundingColor, lineWidth: 3)
                        }
                    }
                }
            Spacer()
            
            TranslationView(text: textRecognizer?.recognizedText ?? "", isProcessing: isProcessing)
            // 이미지가 처리되는 동안 텍스트가 nil이므로 로딩이 완료될 때까지 빈 문자열을 표시
        }
        .padding()
        .trailTheme()
        .navigationTitle("Sign Info")
    }
    
    private var isProcessing: Bool {
        textRecognizer == nil
    }
    
}

#Preview {
    NavigationStack{
        TextRecognitionView(imageResource: .sign1)
            .navigationBarTitleDisplayMode(.inline)
    }
}
