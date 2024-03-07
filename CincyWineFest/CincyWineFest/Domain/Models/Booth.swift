//
//  BoothType.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/3/24.
//

import Foundation

typealias Booths = [Booth]

struct Booth: Codable, Identifiable {
    var id: String {
        return number
    }
    let number: String
    let name: String
    let type: Type
    let countries: Countries
    var wines: Wines
}

extension Booth {
    enum `Type`: String, Codable {
        case wine
        case sponsor
        case food
        case exhibit
        case cocktail
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
}
