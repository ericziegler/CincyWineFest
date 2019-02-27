//
//  Filters.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import Foundation

// MARK: Constants

let FilterPreviousSaveCacheKey = "FilterPreviousSaveCacheKey"
let ShowWineCacheKey = "ShowWineCacheKey"
let ShowFoodCacheKey = "ShowFoodCacheKey"
let ShowExhibitCacheKey = "ShowExhibitCacheKey"
let ShowSponsorCacheKey = "ShowSponsorCacheKey"
let MedalFilterCacheKey = "MedalFilterCacheKey"

enum MedalFilter: Int {
  case allWines = 0
  case gold = 1
  case silver = 2
  case bronze = 3
}

class Filters {
  
  // MARK: Properties
  
  var showSponsor = true
  var showFood = true
  var showExhibit = true
  var medalFilter = MedalFilter.allWines
  
  // MARK: Init
  
  static let shared = Filters()
  
  init() {
    self.loadFilters()
    self.saveFilters()
  }
  
  // MARK: Save / Load
  
  func loadFilters() {
    let defaults = UserDefaults.standard
    if let previousSave = defaults.object(forKey: FilterPreviousSaveCacheKey) as? NSNumber, previousSave.boolValue == true {
      self.showSponsor = defaults.bool(forKey: ShowSponsorCacheKey)
      self.showFood = defaults.bool(forKey: ShowFoodCacheKey)
      self.showExhibit = defaults.bool(forKey: ShowExhibitCacheKey)
      if let medalFilterNumber = defaults.object(forKey: MedalFilterCacheKey) as? NSNumber {
        self.medalFilter = MedalFilter(rawValue: medalFilterNumber.intValue)!
      }
    }
  }
  
  func saveFilters() {
    let defaults = UserDefaults.standard
    let previousSave = NSNumber(booleanLiteral: true)
    defaults.set(previousSave, forKey: FilterPreviousSaveCacheKey)    
    defaults.set(self.showSponsor, forKey: ShowSponsorCacheKey)
    defaults.set(self.showFood, forKey: ShowFoodCacheKey)
    defaults.set(self.showExhibit, forKey: ShowExhibitCacheKey)
    defaults.set(NSNumber(integerLiteral: self.medalFilter.rawValue), forKey: MedalFilterCacheKey)
    defaults.synchronize()
  }
  
}
