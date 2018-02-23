//
//  Wine.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import UIKit

// MARK: Enums

enum BoothType: Int {
 
  case wine = 0
  case food = 1
  case exhibit = 2
  
  var color: UIColor {
    get {
      switch self {
      case .wine:
        return UIColor.white
      case .food:
        return UIColor.white
      case .exhibit:
        return UIColor.white
      }
    }
  }
  
}

enum MedalType: Int {

  case none = 0
  case bronze = 1
  case silver = 2
  case gold = 3

  var image: UIImage? {
    get {
      switch self {
      case .bronze:
        return UIImage(named: "Bronze")
      case .silver:
        return UIImage(named: "Silver")
      case .gold:
        return UIImage(named: "Gold")
      default:
        return nil
      }
    }
  }

}

enum Country: String {
 
  case none = ""
  case argentina = "Argentina"
  case australia = "Australia"
  case austria = "Austria"
  case chile = "Chile"
  case france = "France"
  case germany = "Germany"
  case greece = "Greece"
  case israel = "Israel"
  case italy = "Italy"
  case macedonia = "Macedonia"
  case moldova = "Moldova"
  case newzealand = "New Zealand"
  case sicily = "Sicily"
  case southafrica = "South Africa"
  case spain = "Spain"
  case unitedstates = "United States"
  
  var flag: UIImage? {
    get {
      return UIImage(named: self.rawValue)
    }
  }
  
}

// MARK: Constants

let BoothTypeCacheKey = "BoothTypeCacheKey"
let BoothNumberCacheKey = "BoothNumberCacheKey"
let WineryCacheKey = "WineryCacheKey"
let CountriesCacheKey = "CountriesCacheKey"
let VintageCacheKey = "VintageCacheKey"
let NameCacheKey = "NameCacheKey"
let MedalCacheKey = "MedalCacheKey"
let MapLocationCacheKey = "MapLocationCacheKey"
let IsFavoritedCacheKey = "IsFavoritedCacheKey"
let HasTastedCacheKey = "HasTastedCacheKey"
let NoteCacheKey = "NoteCacheKey"
let RatingCacheKey = "RatingCacheKey"

class Wine: NSObject, NSCoding {
  
  // MARK: Properties
  
  var boothType: BoothType = .wine
  var boothNumber: Int = 0
  var winery: String = ""
  var countries: [Country] = []
  var vintage: String = ""
  var name: String = ""
  var medal: MedalType = .none
  var rating: Int = -1
  var note: String = ""
  private var privateIsFavorited = false
  var isFavorited: Bool {
    return self.privateIsFavorited
  }
  private var privateHasTasted = false
  var hasTasted: Bool {
    return self.privateHasTasted
  }
  var mapLocation: String? {
    get {
      return MapLocationManager.shared.locationFor(winery: self.winery)
    }
  }
  
  // MARK: Init
  
  override init()
  {
    
  }
  
  func load(_ wineString: String) {
    if wineString.count > 0 {
      let props = wineString.components(separatedBy: ",")
      if let boothTypeInt = Int(props[0]), let boothType = BoothType(rawValue: boothTypeInt) {
        self.boothType = boothType
      }
      if let boothNumber = Int(props[1]) {
        self.boothNumber = boothNumber
      }
      self.winery = props[2]
      let countryStrings = props[3].components(separatedBy: "|")
      for curCountryString in countryStrings {
        if let curCountry = Country(rawValue: curCountryString) {
          self.countries.append(curCountry)
        }
      }
      self.vintage = props[4]
      self.name = props[5]
      if let medalInt = Int(props[6]), let medalType = MedalType(rawValue: medalInt) {
        self.medal = medalType
      }
    }
  }
  
  // MARK: Analytics
  
  func toggleTasted() {
    self.privateHasTasted = !self.privateHasTasted
    WineList.shared.saveWinesToCache()
  }
  
  func toggleFavorited() {
    self.privateIsFavorited = !self.isFavorited
    WineList.shared.saveWinesToCache()
  }
  
  func addRating(rating: Int) {
    self.rating = rating
    WineList.shared.saveWinesToCache()
  }
  
  func addNote(note: String) {
    self.note = note
    WineList.shared.saveWinesToCache()
  }
  
  // MARK: NSCoding
  
  required init?(coder decoder: NSCoder) {
    if let winery = decoder.decodeObject(forKey: WineryCacheKey) as? String {
      self.winery = winery
    }
    if let name = decoder.decodeObject(forKey: NameCacheKey) as? String {
      self.name = name
    }
    if let boothTypeNumber = decoder.decodeObject(forKey: BoothTypeCacheKey) as? NSNumber, let boothType = BoothType(rawValue: boothTypeNumber.intValue) {
      self.boothType = boothType
    }
    if let boothNumber = decoder.decodeObject(forKey: BoothNumberCacheKey) as? NSNumber {
      self.boothNumber = boothNumber.intValue
    }
    if let countriesString = decoder.decodeObject(forKey: CountriesCacheKey) as? String {
      let countries = countriesString.components(separatedBy: "|")
      for curCountryString in countries {
        if let curCountry = Country(rawValue: curCountryString) {
          self.countries.append(curCountry)
        }
      }
    }
    if let vintage = decoder.decodeObject(forKey: VintageCacheKey) as? String {
      self.vintage = vintage
    }
    if let medalNumber = decoder.decodeObject(forKey: MedalCacheKey) as? NSNumber, let medalType = MedalType(rawValue: medalNumber.intValue) {
      self.medal = medalType
    }
    if let isFavorited = decoder.decodeObject(forKey: IsFavoritedCacheKey) as? NSNumber {
      self.privateIsFavorited = isFavorited.boolValue
    }
    if let hasTasted = decoder.decodeObject(forKey: HasTastedCacheKey) as? NSNumber {
      self.privateHasTasted = hasTasted.boolValue
    }
    if let rating = decoder.decodeObject(forKey: RatingCacheKey) as? NSNumber {
      self.rating = rating.intValue
    }
    if let note = decoder.decodeObject(forKey: NoteCacheKey) as? String {
      self.note = note
    }
  }
  
  public func encode(with coder: NSCoder) {
    let boothTypeNumber = NSNumber(integerLiteral: self.boothType.rawValue)
    coder.encode(boothTypeNumber, forKey: BoothTypeCacheKey)
    let boothNSNumber = NSNumber(integerLiteral: self.boothNumber)
    coder.encode(boothNSNumber, forKey: BoothNumberCacheKey)
    coder.encode(self.winery, forKey: WineryCacheKey)
    var countries: [String] = []
    for curCountry in self.countries {
      countries.append(curCountry.rawValue)
    }
    coder.encode(countries.joined(separator: "|"))
    coder.encode(self.vintage, forKey: VintageCacheKey)
    coder.encode(self.name, forKey: NameCacheKey)
    let medalNumber = NSNumber(integerLiteral: self.medal.rawValue)
    coder.encode(medalNumber, forKey: MedalCacheKey)
  }
  
}
