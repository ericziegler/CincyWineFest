//
//  Medal.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/3/24.
//

import SwiftUI

enum Medal: String, Codable {
    case none
    case gold
    case silver
    case bronze
    
    var icon: any View {
        switch self {
        case .gold:
            return Image.medalGold
        case .silver:
            return Image.medalSilver
        case .bronze:
            return Image.medalBronze
        default:
            return EmptyView()
        }
    }
}
