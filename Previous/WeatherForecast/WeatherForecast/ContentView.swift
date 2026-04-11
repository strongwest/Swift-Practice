//
//  ContentView.swift
//  WeatherForecast
//
//  Created by 강서현 on 3/27/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack{
            DayForecast(day: "월", isRainy: false, high: 70, low: 50)
            
            DayForecast(day: "화", isRainy: true, high: 60, low: 40)
            
            DayForecast(day: "수", isRainy: true, high: 55, low: 38)
            
        }
    }
}

struct DayForecast: View {
    let day: String
    let isRainy: Bool
    let high: Int
    let low: Int
    
    var iconName: String {
        if isRainy {
            return "cloud.rain.fill"
        } else {
            return "sun.max.fill"
        }
    }
    
    var iconColor: Color {
        if isRainy {
            return Color.blue
        } else {
            return Color.yellow
        }
    }
    
    
    var body: some View {
        HStack{
            VStack {
                Text(day)
                    .font(Font.headline)
                    .fontWeight(Font.Weight.light)
                Image(systemName: iconName)
                    .foregroundStyle(iconColor)
                    .font(Font.largeTitle)
                    .padding(5)
                //SF 심볼은 텍스트와 함께 사용되어 font modifier 적용 가능
                Text("High: \(high)")
                    .fontWeight(Font.Weight.semibold)
                Text("Low: \(low)")
                    .fontWeight(Font.Weight.medium)
                    .foregroundStyle(Color.secondary)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
