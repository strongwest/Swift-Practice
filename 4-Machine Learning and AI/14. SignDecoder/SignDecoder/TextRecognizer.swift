//
//  TextRecognizer.swift
//  SignDecoder
//
//  Created by 강서현 on 5/3/26.
//

import Foundation
import SwiftUI
import Vision

struct TextRecognizer {
    var recognizedText = ""
    var observations: [RecognizedTextObservation] = []
    // RecognizedTextObservation : 비전 프레임워크를 통해 식별된 텍스트 뭉치
    
    // async 비동기
    init(imageResource: ImageResource) async {
        var request = RecognizeTextRequest()
        request.recognitionLevel = .accurate
        
        let image = UIImage(resource: imageResource)
        
        // UIImage를 이미지 데이터로 변환하고
        if let imageData = image.pngData(),
           // 텍스트 인식 결과가 있으면
           // try? : 결과가 있을 때만(성공했을 때만) 진행
           let results = try? await request.perform(on: imageData){
            observations = results
        }
        
        for observation in observations {
            let candidate = observation.topCandidates(1)
            // 관측값 중 가장 가능성 높은 후보
            
            if let observedText = candidate.first?.string {
                recognizedText += "\(observedText)"
            }
            
        }
        
    }
}
