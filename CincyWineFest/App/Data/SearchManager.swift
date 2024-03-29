//
//  SearchManager.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import Foundation

class SearchManager {
  
  // MARK: Properties
  
  var wineries = [Wine]()
  var wines = [Wine]()
  var countries = [Wine]()
  var goldMedals = [Wine]()
  var silverMedals = [Wine]()
  var bronzeMedals = [Wine]()
  
  // MARK: Search
  
  func performSearch(for text: String) {
    self.clearData()
    
    if (text.count > 1) {
      let lowercaseText = text.lowercased()
      let list = WineList.shared.wines
      
      for curWine in list {
        // search wineries
        if (lowercaseText == String(curWine.boothNumber)) {
          self.wineries.append(curWine)
        }
        else if (curWine.winery.lowercased().contains(lowercaseText)) {
          self.wineries.append(curWine)
        }
        // search wine names
        if (curWine.name.lowercased().contains(lowercaseText)) {
          self.wines.append(curWine)
        }
        // search countries
        for curCountry in curWine.countries {
          if curCountry.rawValue.lowercased().contains(lowercaseText) {
            self.countries.append(curWine)
            break
          }
        }
        // search gold medals
        if (lowercaseText.lowercased().hasPrefix("gol") && curWine.medal == .gold) {
          self.goldMedals.append(curWine)
        }
        // search silver medals
        if (lowercaseText.lowercased().hasPrefix("sil") && curWine.medal == .silver) {
          self.silverMedals.append(curWine)
        }
        // search bronze medals
        if (lowercaseText.lowercased().hasPrefix("bro") && curWine.medal == .bronze) {
          self.bronzeMedals.append(curWine)
        }
        
        if (lowercaseText.lowercased().hasPrefix("meda") && curWine.medal != .none) {
          if curWine.medal == .bronze {
            self.bronzeMedals.append(curWine)
          }
          else if curWine.medal == .silver {
            self.silverMedals.append(curWine)
          }
          else if curWine.medal == .gold {
            self.goldMedals.append(curWine)
          }
        }
      }
    }
  }
  
  func clearData() {
    self.wineries.removeAll()
    self.wines.removeAll()
    self.countries.removeAll()
    self.goldMedals.removeAll()
    self.silverMedals.removeAll()
    self.bronzeMedals.removeAll()
  }
  
}
