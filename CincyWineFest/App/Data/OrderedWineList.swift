//
//  OrderedWineList.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import Foundation

// MARK: Constants

class OrderedWineList {
  
  // MARK: Properties
  
  var sortedKeys = [Int]()
  var wines =  [Int : [Wine]]()
  
  // MARK: Init
  
  static let shared = OrderedWineList()
  
  init() {
    self.orderWines()
  }
  
  func orderWines() {
    self.sortedKeys = [Int]()
    self.wines = [Int : [Wine]]()
    
    let unsortedWines = WineList.shared.filteredWines
    
    for curWine in unsortedWines {
      if !Array(self.wines.keys).contains(curWine.boothNumber) {
        self.wines[curWine.boothNumber] = []
      }
      self.wines[curWine.boothNumber]?.append(curWine)
    }
    self.sortedKeys = Array(self.wines.keys).sorted(by: <)
  }
  
}
