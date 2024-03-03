//
//  AppDelegate.swift
//  CincyWineFest
//LJN opyright © 2018 zigabytes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // UI
    applyApplicationAppearanceProperties()
    
    if let tabBarController = self.window?.rootViewController as? UITabBarController {
      let tabBar = tabBarController.tabBar
      applyIconColorsFor(tabBar: tabBar)
    }
    
    window?.backgroundColor = UIColor.white
    
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    checkCurrentAppVersion()
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    
  }

}

