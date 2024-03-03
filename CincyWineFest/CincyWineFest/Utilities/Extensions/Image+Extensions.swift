//
//  Image+Extensions.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/2/24.
//

import SwiftUI

extension Image {
    
    // MARK: - Tabs
 
    static var tabWine: some View {
        Image("tab.wine.glass")
            .resizeAndFit()
            .foregroundStyle(.white)
    }
    
    static var tabWineFilled: some View {
        Image("tab.wine.glass.fill")
            .resizeAndFit()
            .foregroundStyle(.appSecondary)
    }
    
    static var tabSearch: some View {
        Image(systemName: "magnifyingglass")
            .resizeAndFit()
            .foregroundStyle(.white)
    }
    
    static var tabSearchFilled: some View {
        Image(systemName: "magnifyingglass")
            .resizeAndFit()
            .foregroundStyle(.appSecondary)
    }
    
    static var tabMyList: some View {
        Image("tab.target")
            .resizeAndFit()
            .foregroundStyle(.white)
    }
    
    static var tabMyListFilled: some View {
        Image("tab.target")
            .resizeAndFit()
            .foregroundStyle(.appSecondary)
    }
    
    static var tabTasted: some View {
        Image("tab.check")
            .resizeAndFit()
            .foregroundStyle(.white)
    }
    
    static var tabTastedFilled: some View {
        Image("tab.check")
            .resizeAndFit()
            .foregroundStyle(.appSecondary)
    }
    
    static var tabMap: some View {
        Image(systemName: "map")
            .resizeAndFit()
            .foregroundStyle(.white)
    }
    
    static var tabMapFilled: some View {
        Image(systemName: "map.fill")
            .resizeAndFit()
            .foregroundStyle(.appSecondary)
    }
    
    // MARK: - Flags
    
    static var flagArgentina: some View {
        Image("Argentina").resizeAndFit()
    }
    
    static var flagAustralia: some View {
        Image("Australia").resizeAndFit()
    }

    static var flagAustria: some View {
        Image("Austria").resizeAndFit()
    }
    
    static var flagChile: some View {
        Image("Chile").resizeAndFit()
    }
    
    static var flagFrance: some View {
        Image("France").resizeAndFit()
    }
    
    static var flagGermany: some View {
        Image("Germany").resizeAndFit()
    }
    
    static var flagGreece: some View {
        Image("Greece").resizeAndFit()
    }
    
    static var flagIsrael: some View {
        Image("Israel").resizeAndFit()
    }
    
    static var flagItaly: some View {
        Image("Italy").resizeAndFit()
    }
    
    static var flagMacedonia: some View {
        Image("Macedonia").resizeAndFit()
    }
    
    static var flagMoldova: some View {
        Image("Moldova").resizeAndFit()
    }
    
    static var flagNewZealand: some View {
        Image("NewZealand").resizeAndFit()
    }
    
    static var flagPortugal: some View {
        Image("Portugal").resizeAndFit()
    }
    
    static var flagSouthAfrica: some View {
        Image("SouthAfrica").resizeAndFit()
    }
    
    static var flagSpain: some View {
        Image("Spain").resizeAndFit()
    }
    
    static var flagUnitedStates: some View {
        Image("UnitedStates").resizeAndFit()
    }
    
    // MARK: - Icons
    
    static var star: some View {
        Image(systemName: "star")
            .resizeAndFit()
            .foregroundStyle(.textSecondary)
    }
    
    static var starFilled: some View {
        Image(systemName: "star.fill")
            .resizeAndFit()
            .foregroundStyle(.ratingYellow)
    }
    
    // MARK: - Medals
    
    static var medalGold: some View {
        Image("medal.gold")
            .resizeAndFit()
    }
    
    static var medalSilver: some View {
        Image("medal.silver")
            .resizeAndFit()
    }
    
    static var medalBronze: some View {
        Image("medal.bronze")
            .resizeAndFit()
    }
    
    // MARK: - Helpers
    
    func resizeAndFill() -> some View {
        self
            .resizable()
            .scaledToFill()
    }
    
    func resizeAndFit() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
}
