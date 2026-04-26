//
//  HexagonAccessoryView.swift
//  GratefulMoments
//
//  Created by 강서현 on 4/26/26.
//

import SwiftUI

struct HexagonAccessoryView: View {
    
    let moment: Moment
    let hexagonLayout: HexagonLayout
    
    var body: some View {
        
        NavigationLink{
            if badges.count == 1 {
                BadgeDetailView(badge: badges[0])
            } else {
                MomentDetailView(moment: moment)
            }
        } label: {
            badgeView
        }
    }
        
    private var badgeView: some View{
        Group {
            if badges.count > 1 {
                Text("+\(badges.count)")
                    .bold()
                    .frame(width: size * 0.5, height: size * 0.5)
                    .padding(8)
                    .background {
                        Image("Blank")
                            .resizable()
                            .frame(width: size, height: size)
                            .shadow(radius: 2)
                    }
                    .foregroundStyle(.gray)
            } else if let badge = badges.first {
                Image(badge.details.image)
                    .resizable()
                    .frame(width: size, height: size)
                    .shadow(radius: 2)
            }
        }
        .offset(y: yOffset)
    }
    
    private var yOffset: CGFloat {
        let radius = hexagonLayout.size / 2
        let yOffsetFromHexagonCenter = sin(Angle.degrees(30).radians) * radius
        return radius - yOffsetFromHexagonCenter - (size / 2)
    }
    
    private var badges: [Badge] {
        moment.badges
    }
    
    private var size: CGFloat {
        hexagonLayout.size / 5
    }
}

#Preview("single badge") {
    HexagonAccessoryView(moment: .sample, hexagonLayout: .large)
        .sampleDataContainer()
}

#Preview("multiple badge") {
    HexagonAccessoryView(moment: .imageSample, hexagonLayout: .large)
        .sampleDataContainer()
}
