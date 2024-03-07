//
//  Country.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/3/24.
//

import Foundation

typealias Countries = [Country]

enum Country: String, Codable {
    case none = ""
    case argentina
    case australia
    case austria
    case chile
    case france
    case germany
    case greece
    case israel
    case italy
    case macedonia
    case moldova
    case newzealand
    case portugal
    case sicily
    case southafrica
    case spain
    case unitedstates
    
    var formattedName: String {
        switch self {
        case .southafrica:
            return "South Africa"
        case .newzealand:
            return "New Zealand"
        case .unitedstates:
            return "United States"
        default:
            return self.rawValue.capitalized
        }
      }
}
