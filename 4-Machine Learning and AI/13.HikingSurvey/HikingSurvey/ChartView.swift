//
//  ChartView.swift
//  HikingSurvey
//
//  Created by 강서현 on 5/1/26.
//

import SwiftUI
import Charts

struct ChartView: View {
    var responses: [Response]
    
    init(responses: [Response]){
        self.responses = responses.sorted { $0.score < $1.score}
    }
    // 점수별로 소팅
    
    var body: some View {
        Chart(responses) { response in
            SectorMark(angle: .value("Type", 1), innerRadius: .ratio(0.7))
                .foregroundStyle(by: .value("sentiment", response.sentiment))
            // 데이터(sentiment)에 따라 색을 나누는 그루핑 선언(기준 부여)
        }
        // 구체적인 스타일 정의
        .chartForegroundStyleScale([
            Sentiment.positive : Sentiment.positive.sentimentColor,
            Sentiment.negative : Sentiment.negative.sentimentColor,
            Sentiment.moderate : Sentiment.moderate.sentimentColor,
        ])
        .chartBackground{ chartProxy in
            GeometryReader { geometry in
                if let anchor = chartProxy.plotFrame {
                    let frame = geometry[anchor]
                    Image(systemName: "figure.hiking")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: frame.height * 0.4)
                        .foregroundStyle(Color(white: 0.59))
                        .position(x: frame.midX, y: frame.midY)
                }
            }
        }
        .chartLegend(position: .trailing, alignment: .center)
        .frame(height: 200)
        .padding()
    }
}


#Preview {
    ContentView()
}
