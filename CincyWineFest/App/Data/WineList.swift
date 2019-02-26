//
//  WineList.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import Foundation

// MARK: Constants

let WineListCacheKey = "WineListCacheKey"

class WineList {
  
  // MARK: Properties
  
  var wines: [Wine] = []
  var filteredWines: [Wine] {
    var result = [Wine]()
    var canAddWine = true
    let filters = Filters.shared
    
    for curWine in self.wines {
      canAddWine = true
      
      if (filters.showFood == false && curWine.boothType == .food) {
        canAddWine = false
      }
      else if (filters.showWine == false && curWine.boothType == .wine) {
        canAddWine = false
      }
      else if (filters.showSponsor == false && curWine.boothType == .sponsor) {
        canAddWine = false
      }
      else if (filters.showExhibit == false && curWine.boothType == .exhibit) {
        canAddWine = false
      }
      else if (filters.showWine == false && filters.medalFilter == .allWines) {
        canAddWine = false
      }
      else if (filters.showWine == false || (filters.medalFilter == .gold && curWine.medal != .gold)) {
        canAddWine = false
      }
      else if (filters.showWine == false || (filters.medalFilter == .silver && curWine.medal != .silver)) {
        canAddWine = false
      }
      else if (filters.showWine == false || (filters.medalFilter == .bronze && curWine.medal != .bronze)) {
        canAddWine = false
      }
      
      if (canAddWine) {
        result.append(curWine)
      }
    }
    
    return result
  }
  
  // MARK: Init
  
  static let shared = WineList()
  
  init() {
    self.loadWines()
  }
  
  // MARK: Loading
  
  func loadWines() {
    if self.loadWinesFromCache() == false {
      self.loadWinesFromCSV()
      // TODO: EZ - Comment in the caching of wine data
      //self.saveWinesToCache()
    }
  }
  
  private func loadWinesFromCache() -> Bool {
    var result = false
    
    if let wineListData = UserDefaults.standard.data(forKey: WineListCacheKey) {
      if let wines = NSKeyedUnarchiver.unarchiveObject(with: wineListData) as? [Wine] {
        self.wines = wines
        result = true
      }
    }
    
    return result
  }
  
  func clearWineCache() {
    UserDefaults.standard.removeObject(forKey: WineListCacheKey)
  }
  
  private func loadWinesFromCSV() {
    self.wines = []
    
    if let winePath = Bundle.main.path(forResource: "list", ofType: "csv") {
      self.loadWinesFromFile(winePath)
    }
    
    self.wines.sort {
      $0.boothNumber < $1.boothNumber
    }
  }
  
  private func loadWinesFromFile(_ fileName: String) {
    do {
      let wineCSV = try String(contentsOfFile: fileName, encoding: String.Encoding.utf8)
      let wineArray = wineCSV.components(separatedBy: "\n")
      for wineItem in wineArray {
        let wine = Wine()
        wine.load(wineItem)
        if (wine.winery.count > 0) {
          self.wines.append(wine)
        }
      }
      
    } catch{
      debugPrint(error)
    }
  }
  
  // MARK: Saving
  
  func saveWinesToCache() {
    let wineListData = NSKeyedArchiver.archivedData(withRootObject: self.wines)
    UserDefaults.standard.set(wineListData, forKey: WineListCacheKey)
  }
  
}
