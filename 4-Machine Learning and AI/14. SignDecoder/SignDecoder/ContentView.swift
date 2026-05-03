//
//  ContentView.swift
//  SignDecoder
//
//  Created by 강서현 on 5/2/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 50) {
                
                Text("번역하고 싶은 표지판을 선택하세요")
                    .font(.headline)
                
                ImageGalleryView()
                Spacer()
            }
            .trailTheme()
            .navigationTitle("Sign Decoder")
        }
    }
}

#Preview {
    ContentView()
}
