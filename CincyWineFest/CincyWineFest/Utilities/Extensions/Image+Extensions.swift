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
        Image("wine.glass")
            .resizeAndFit()
            .foregroundStyle(.white)
    }
    
    static var tabWineFilled: some View {
        Image("wine.glass.fill")
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
        Image("target")
            .resizeAndFit()
            .foregroundStyle(.white)
    }
    
    static var tabMyListFilled: some View {
        Image("target")
            .resizeAndFit()
            .foregroundStyle(.appSecondary)
    }
    
    static var tabTasted: some View {
        Image("checkmark")
            .resizeAndFit()
            .foregroundStyle(.white)
    }
    
    static var tabTastedFilled: some View {
        Image("checkmark")
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
