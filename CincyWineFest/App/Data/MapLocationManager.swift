//
//  MapLocationManager.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import Foundation

class MapLocationManager {
  
  static let shared = MapLocationManager()
  
  var locations = [String : String]()
  
  init() {
    self.loadLocations()
  }
  
  private func loadLocations() {
    if let locationsPath = Bundle.main.path(forResource: "map", ofType: "csv") {
      do {
        let locationCSV = try String(contentsOfFile: locationsPath, encoding: String.Encoding.utf8)
        let locationArray = locationCSV.components(separatedBy: "\n")
        for locationItem in locationArray {
          if !locationItem.isEmpty {
            let items = locationItem.components(separatedBy: ",")
            self.locations[items[0].replacingOccurrences(of: "'", with: "").replacingOccurrences(of: " ", with: "").lowercased()] = items[1]
          }
        }
        
      } catch{
        debugPrint(error)
      }
    }
  }
  
  func locationFor(winery: String) -> String? {
    let formattedBrewery = winery.replacingOccurrences(of: "'", with: "").replacingOccurrences(of: " ", with: "").lowercased()
    for curItem in Array(self.locations.keys) {
      if curItem.contains(formattedBrewery) {
        return self.locations[curItem]
      }
    }
    return nil
  }
  
}
