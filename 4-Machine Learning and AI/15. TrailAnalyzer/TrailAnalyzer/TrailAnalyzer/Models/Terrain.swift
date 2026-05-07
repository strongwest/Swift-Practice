//
//  Terrain.swift
//  TrailAnalyzer
//
//  Created by 강서현 on 5/7/26.
//

import Foundation

enum Terrain: String, Identifiable, CaseIterable {
    case paved
    case dirt
    case rocky
    case sandy
    
    var id: String {
            rawValue
        }
    
}

