//
//  TrailTheme.swift
//  SignDecoder
//
//  Created by 강서현 on 5/3/26.
//

import Foundation
import SwiftUI

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
