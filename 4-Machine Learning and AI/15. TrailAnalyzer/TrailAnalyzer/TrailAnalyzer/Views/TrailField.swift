//
//  TrailField.swift
//  TrailAnalyzer
//
//  Created by 강서현 on 5/7/26.
//

import SwiftUI

struct TrailField<Content: View>: View {
    var iconName: String
    var label: String
    @ViewBuilder var content: Content
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .foregroundStyle(Color.trailTheme)
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(.trailing, 8)
            Text(label)
            Spacer()
            content
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
        .background(.white, in: RoundedRectangle(cornerRadius: 12))
    }
}


#Preview {
    TrailField(iconName: "figure.hiking", label: "Label"){
        Text("Content")
    }
        .trailTheme()
}
