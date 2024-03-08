//
//  Filters.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/8/24.
//

import Foundation

struct Filters: Codable {
    var hasActiveFilter: Bool {
        if showGoldMedals || showSilverMedals || showBronzeMedals {
            return true
        }
        
        if !showWineBooths || !showSponsorBooths || !showFoodBooths || !showExhibitBooths || !showWaterNonAlcoholicBooths {
            return true
        }
        
        return false
    }
    var showGoldMedals: Bool = false
    var showSilverMedals: Bool = false
    var showBronzeMedals: Bool = false
    
    var showWineBooths: Bool = true
    var showSponsorBooths: Bool = true
    var showFoodBooths: Bool = true
    var showExhibitBooths: Bool = true
    var showWaterNonAlcoholicBooths: Bool = true
}
