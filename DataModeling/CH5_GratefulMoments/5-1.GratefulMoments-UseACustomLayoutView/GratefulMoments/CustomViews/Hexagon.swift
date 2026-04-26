//
//  Hexagon.swift
//  GratefulMoments
//
//  Created by 강서현 on 4/20/26.
//

import SwiftUI

struct Hexagon<Content: View>: View {
    private let borderWidth = 2.0
    var borderColor: Color = .ember
    var layout: HexagonLayout = .standard
    var size: CGFloat = 350
    var moment: Moment? = nil
    
    @ViewBuilder var content: () -> Content
    // Hexagon을 VStack 등처럼 사용할 수 있음(프리뷰 참고)
    
    var body: some View {
        ZStack{
            if let background = moment?.image {
                Image(uiImage: background)
                    .resizable()
                    .scaledToFill()
            }
            content()
                .frame(width: layout.size, height: layout.size)
        }
        .mask{
            Image(systemName: "hexagon.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: layout.size - borderWidth, height: layout.size - borderWidth)
            // 이미지 크기를 테두리 굵기 만큼 빼서(-) 테두리를 만드는 방식
        }
        .background {
            Image(systemName: "hexagon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: layout.size, height: layout.size)
                .foregroundStyle(borderColor)
        }
        .frame(width: layout.size, height: layout.size)
    }
}

#Preview {
    Hexagon(moment: Moment.imageSample){
        Text(Moment.imageSample.title)
            .foregroundStyle(Color.white)
    }
    .sampleDataContainer()
}
