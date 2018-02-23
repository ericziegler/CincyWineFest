//
//  FavoriteWineList.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import Foundation

class FavoriteWineList {
  
  // MARK: Properties
  
  var wines: [Wine] {
    get {
      var result = [Wine]()
      
      for curWine in WineList.shared.filteredWines {
        if (curWine.isFavorited) {
          result.append(curWine)
        }
      }
      
      return result
    }
  }
  
  // MARK: Init
  
  static let shared = FavoriteWineList()
  
}
