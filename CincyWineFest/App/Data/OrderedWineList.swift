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
    var key = 0
    
    for curWine in unsortedWines {
      let booth = curWine.boothNumber
      if booth >= 0 && booth < 5 {
        key = 1
      }
      else if booth >= 5 && booth < 10 {
        key = 5
      }
      else if booth >= 10 && booth < 15 {
        key = 10
      }
      else if booth >= 15 && booth < 20 {
        key = 15
      }
      else if booth >= 20 && booth < 25 {
        key = 20
      }
      else if booth >= 25 && booth < 30 {
        key = 25
      }
      else if booth >= 30 && booth < 35 {
        key = 30
      }
      else if booth >= 35 && booth < 40 {
        key = 35
      }
      else if booth >= 40 && booth < 45 {
        key = 40
      }
      else if booth >= 45 && booth < 50 {
        key = 45
      }
      else if booth >= 50 && booth < 55 {
        key = 50
      }
      else if booth >= 55 && booth < 60 {
        key = 55
      }
      else if booth >= 60 && booth < 65 {
        key = 60
      }
      else if booth >= 65 && booth < 70 {
        key = 65
      }
      else if booth >= 70 && booth < 75 {
        key = 70
      }
      else if booth >= 75 && booth < 80 {
        key = 75
      }
      else if booth >= 80 && booth < 85 {
        key = 80
      }
      else if booth >= 85 && booth < 90 {
        key = 85
      }
      else if booth >= 90 && booth < 95 {
        key = 90
      }
      else if booth >= 95 && booth < 100 {
        key = 95
      }
      else if booth >= 100 && booth < 105 {
        key = 100
      }
      else if booth >= 105 && booth < 110 {
        key = 105
      }
      else if booth >= 110 && booth < 115 {
        key = 110
      }
      else if booth >= 115 && booth < 120 {
        key = 115
      }
      else if booth >= 120 && booth < 125 {
        key = 120
      }
      else if booth >= 125 && booth < 130 {
        key = 125
      }
      else if booth >= 130 && booth <= 138 {
        key = 130
      }
      if !Array(self.wines.keys).contains(key) {
        self.wines[key] = []
      }
      self.wines[key]?.append(curWine)
    }
    self.sortedKeys = Array(self.wines.keys).sorted(by: <)
  }
  
}
