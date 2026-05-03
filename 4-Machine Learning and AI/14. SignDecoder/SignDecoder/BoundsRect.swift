//
//  BoundsRect.swift
//  SignDecoder
//
//  Created by 강서현 on 5/3/26.
//

import Foundation
import SwiftUI
import Vision

struct BoundsRect: Shape {
    let normalizedRect: NormalizedRect
    
    func path(in rect: CGRect) -> Path {
        let imageCoordinatesRect = normalizedRect.toImageCoordinates(rect.size, origin: .upperLeft)
            // 이미지 좌표로 전환
        return Path(imageCoordinatesRect)
    }
}
