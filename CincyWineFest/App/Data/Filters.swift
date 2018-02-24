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
let ShowGoldCacheKey = "ShowGoldCacheKey"
let ShowSilverCacheKey = "ShowSilverCacheKey"
let ShowBronzeCacheKey = "ShowBronzeCacheKey"

class Filters {
  
  // MARK: Properties
  
  var showWine = true
  var showSponsor = true
  var showFood = true
  var showExhibit = true
  var showGold = true
  var showSilver = true
  var showBronze = true
  
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
      self.showWine = defaults.bool(forKey: ShowWineCacheKey)
      self.showSponsor = defaults.bool(forKey: ShowSponsorCacheKey)
      self.showFood = defaults.bool(forKey: ShowFoodCacheKey)
      self.showExhibit = defaults.bool(forKey: ShowExhibitCacheKey)
      self.showGold = defaults.bool(forKey: ShowGoldCacheKey)
      self.showSilver = defaults.bool(forKey: ShowSilverCacheKey)
      self.showBronze = defaults.bool(forKey: ShowBronzeCacheKey)
    }
  }
  
  func saveFilters() {
    let defaults = UserDefaults.standard
    let previousSave = NSNumber(booleanLiteral: true)
    defaults.set(previousSave, forKey: FilterPreviousSaveCacheKey)
    defaults.set(self.showWine, forKey: ShowWineCacheKey)
    defaults.set(self.showSponsor, forKey: ShowSponsorCacheKey)
    defaults.set(self.showFood, forKey: ShowFoodCacheKey)
    defaults.set(self.showExhibit, forKey: ShowExhibitCacheKey)
    defaults.set(self.showGold, forKey: ShowGoldCacheKey)
    defaults.set(self.showSilver, forKey: ShowSilverCacheKey)
    defaults.set(self.showBronze, forKey: ShowBronzeCacheKey)
    defaults.synchronize()
  }
  
}
