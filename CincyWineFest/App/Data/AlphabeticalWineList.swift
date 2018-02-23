//
//  AlphabeticalWineList.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import Foundation

// MARK: Constants

let NumberString = "0123456789"

class AlphabeticalWineList {
  
  // MARK: Properties
  
  var sortedKeys = [String]()
  var wines =  [String : [Wine]]()
  
  // MARK: Init
  
  static let shared = AlphabeticalWineList()
  
  init() {
    self.alphabetizeWines()
  }
  
  func alphabetizeWines() {
    self.sortedKeys = [String]()
    self.wines = [String : [Wine]]()
    
    let unsortedWines = WineList.shared.filteredWines
    
    self.wines["#"] = [Wine]()
    
    for curWine in unsortedWines {
      if let firstChar = curWine.winery.first {
        let charString = String(firstChar)
        if (self.wines.keys.contains(charString)) {
          self.wines[charString]?.append(curWine)
        } else {
          if (NumberString.contains(charString)) {
            self.wines["#"]?.append(curWine)
          } else {
            self.wines[charString] = [Wine]()
            self.wines[charString]?.append(curWine)
          }
        }
      }
    }
    self.sortedKeys = Array(self.wines.keys).sorted(by: <)
  }
  
}
