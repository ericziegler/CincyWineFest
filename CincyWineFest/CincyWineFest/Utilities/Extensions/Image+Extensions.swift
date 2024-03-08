//
//  Image+Extensions.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/2/24.
//

import SwiftUI

extension Image {
    
    // MARK: - Tabs
 
    static var tabWine: Image {
        Image(systemName: "wineglass")
    }
    
    static var tabWineFilled: Image {
        Image(systemName: "wineglass.fill")
    }
    
    static var tabSearch: Image {
        Image(systemName: "magnifyingglass")
    }
    
    static var tabSearchFilled: Image {
        Image(systemName: "magnifyingglass")
    }
    
    static var tabMyList: Image {
        Image("tab.target")
    }
    
    static var tabMyListFilled: Image {
        Image("tab.target")
    }
    
    static var tabTasted: Image {
        Image("tab.check")
    }
    
    static var tabTastedFilled: Image {
        Image("tab.check")
    }
    
    static var tabMap: Image {
        Image(systemName: "map")
    }
    
    static var tabMapFilled: Image {
        Image(systemName: "map.fill")
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
    
    static var brokenGlass: some View {
        Image("BrokenGlass")
            .resizeAndFit()
    }
    
    static var filterDials: some View {
        Image("FilterDials")
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
