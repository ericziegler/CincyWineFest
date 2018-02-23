//
//  WineFestUI.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import UIKit

// MARK: Global Properties

func applyApplicationAppearanceProperties() {
  UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font : UIFont.applicationFontOfSize(17)], for: UIControlState())
  UINavigationBar.appearance().tintColor = UIColor.lightAccent
  UINavigationBar.appearance().barTintColor = UIColor.navBar
  UITabBar.appearance().tintColor = UIColor.lightAccent
  UITabBar.appearance().barTintColor = UIColor.tabBar
  UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font : UIFont.applicationFontOfSize(14.0), NSAttributedStringKey.foregroundColor : UIColor.tabBarNormal], for: .normal)
  UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font : UIFont.applicationFontOfSize(14.0), NSAttributedStringKey.foregroundColor : UIColor.lightAccent], for: .selected)
}

func navTitleTextAttributes() -> [NSAttributedStringKey : Any] {
  return [NSAttributedStringKey.font : UIFont.applicationBoldFontOfSize(21.0), NSAttributedStringKey.foregroundColor : UIColor.navBarTitle]
}

func applyIconColorsFor(tabBar: UITabBar) {
  if let items = tabBar.items {
    for curItem in items {
      curItem.image = curItem.image?.maskedImageWithColor(UIColor.tabBarNormal)?.withRenderingMode(.alwaysOriginal)
    }
  }
}

// MARK: Styled Labels

class ApplicationStyleLabel : UILabel {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.preInit();
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.preInit()
  }
  
  func preInit() {
    if let text = self.text, text.hasPrefix("^") {
      self.text = nil
    }
    self.commonInit()
  }
  
  func commonInit() {
    if type(of: self) === ApplicationStyleLabel.self {
      fatalError("ApplicationStyleLabel not meant to be used directly. Use its subclasses.")
    }
  }
}

class RegularLabel: ApplicationStyleLabel {
  override func commonInit() {
    self.font = UIFont.applicationFontOfSize(self.font.pointSize)
  }
}

class BoldLabel: ApplicationStyleLabel {
  override func commonInit() {
    self.font = UIFont.applicationBoldFontOfSize(self.font.pointSize)
  }
}

class LightLabel: ApplicationStyleLabel {
  override func commonInit() {
    self.font = UIFont.applicationLightFontOfSize(self.font.pointSize)
  }
}
