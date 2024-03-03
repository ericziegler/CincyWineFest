//
//  Booth.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/3/24.
//

import Foundation

enum Booth: String, Codable {
    case wine
    case sponsor
    case food
    case exhibit
    case waterNonAlcoholic
    
    var displayText: String {
        switch self {
        case .waterNonAlcoholic:
            return "Water/Non-Alcoholic"
        default:
            return self.rawValue.capitalized
        }
    }
}
