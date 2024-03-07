//
//  Country.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/3/24.
//

import SwiftUI

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
    
    var flag: any View {
        switch self {
        case .argentina:
            return Image.flagArgentina
        case .australia:
            return Image.flagAustralia
        case .austria:
            return Image.flagAustria
        case .chile:
            return Image.flagChile
        case .france:
            return Image.flagFrance
        case .germany:
            return Image.flagGermany
        case .greece:
            return Image.flagGreece
        case .israel:
            return Image.flagIsrael
        case .italy:
            return Image.flagItaly
        case .macedonia:
            return Image.flagMacedonia
        case .moldova:
            return Image.flagMoldova
        case .newzealand:
            return Image.flagNewZealand
        case .portugal:
            return Image.flagPortugal
        case .southafrica:
            return Image.flagSouthAfrica
        case .spain:
            return Image.flagSpain
        case .unitedstates:
            return Image.flagUnitedStates
        case .none:
            return EmptyView()
        }
    }
}
