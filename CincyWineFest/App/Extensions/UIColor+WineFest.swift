//
//  UIColor+WineFest.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import UIKit

extension UIColor {
  
  convenience init(hex: Int, alpha: CGFloat = 1.0) {
    let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
    let g = CGFloat((hex & 0x00FF00) >> 08) / 255.0
    let b = CGFloat((hex & 0x0000FF) >> 00) / 255.0
    self.init(red:r, green:g, blue:b, alpha:alpha)
  }
  
  convenience init(integerRed red: Int, green: Int, blue: Int, alpha: Int = 255) {
    let r = CGFloat(red) / 255.0
    let g = CGFloat(green) / 255.0
    let b = CGFloat(blue) / 255.0
    let a = CGFloat(alpha) / 255.0
    self.init(red:r, green:g, blue:b, alpha:a)
  }
  
  class var navBar: UIColor {
    return UIColor(hex: 0x55317e)
  }
  
  class var tabBar: UIColor {
    return UIColor.navBar
  }
  
  class var accent: UIColor {
    return UIColor(hex: 0x87b14f)
  }
  
  class var lightAccent: UIColor {
    return UIColor(hex: 0x98fb98)
  }
  
  class var goldAccent: UIColor {
    return UIColor(hex: 0xfbe68e)
  }
  
  class var silverAccent: UIColor {
    return UIColor(hex: 0xcccccc)
  }
  
  class var bronzeAccent: UIColor {
    return UIColor(hex: 0x9c8938)
  }
  
  class var navBarTitle: UIColor {
    return UIColor.white
  }
  
  class var tabBarNormal: UIColor {
    return UIColor.white
  }
  
  class var mapBackground: UIColor {
    return UIColor(hex: 0xeeeeee)
  }
  
  class var lightText: UIColor {
    return UIColor(hex: 0xcccccc, alpha: 1)
  }
  
  class var mediumText: UIColor {
    return UIColor(hex: 0x777777, alpha: 1)
  }
  
  class var darkText: UIColor {
    return UIColor(hex: 0x111111, alpha: 1)
  }
  
  class var mainBackground: UIColor {
    return UIColor(hex: 0xffffff, alpha: 1)
  }
  
  class var sponsor: UIColor {
    return UIColor(hex: 0x71bede)
  }
  
  class var food: UIColor {
    return UIColor(hex: 0xffc17c)
  }
  
  class var exhibit: UIColor {
    return UIColor(hex: 0xd2839b)
  }
  
  class var sponsorBold: UIColor {
    return UIColor(hex: 0x67adc9)
  }
  
  class var foodBold: UIColor {
    return UIColor(hex: 0xd9a56a)
  }
  
  class var exhibitBold: UIColor {
    return UIColor(hex: 0xa6677b)
  }
  
  class var bronzeMedal: UIColor {
    return UIColor(hex: 0x7c661e)
  }
  class var silverMedal: UIColor {
    return UIColor(hex: 0x999999)
  }
  class var goldMedal: UIColor {
    return UIColor(hex: 0xf7cd46)
  }
  class var wine: UIColor {
    return UIColor.navBar
  }
  
}
