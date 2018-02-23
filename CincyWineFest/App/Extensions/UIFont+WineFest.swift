//
//  UIFont+WineFest.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import UIKit

extension UIFont {
  
  class func applicationFontOfSize(_ size: CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue", size: size)!
  }
  
  class func applicationBoldFontOfSize(_ size: CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue-Bold", size: size)!
  }
  
  class func applicationLightFontOfSize(_ size: CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue-Light", size: size)!
  }
  
  class func debugListFonts() {
    UIFont.familyNames.forEach({ familyName in
      let fontNames = UIFont.fontNames(forFamilyName: familyName)
      print(familyName, fontNames)
    })
  }
  
}
