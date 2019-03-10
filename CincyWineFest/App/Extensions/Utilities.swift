//
//  Utilities.swift
//  CincyWineFest
//
//  Created by Zigabytes on 2/17/19.
//  Copyright © 2019 zigabytes. All rights reserved.
//

import Foundation

let CurrentAppVersionCacheKey = "CurrentAppVersionCacheKey"

func checkCurrentAppVersion() {
  let currentAppVersion =  UserDefaults.standard.integer(forKey: CurrentAppVersionCacheKey)
  if let appVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as? String, let appVersionNumber = Int(appVersion), currentAppVersion < appVersionNumber {
      WineList.shared.clearWineCache()
      UserDefaults.standard.set(appVersionNumber, forKey: CurrentAppVersionCacheKey)
  }
}
