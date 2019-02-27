//
//  FiltersViewController.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import UIKit

// MARK: Constants

let FiltersViewId = "FiltersViewId"

class FiltersViewController: BaseViewController {
  
  // MARK: Properties
  
  @IBOutlet var sponsorSwitch: UISwitch!
  @IBOutlet var foodSwitch: UISwitch!
  @IBOutlet var exhibitSwitch: UISwitch!
  
  // MARK: Init
  
  class func createController() -> FiltersViewController {
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController: FiltersViewController = storyboard.instantiateViewController(withIdentifier: FiltersViewId) as! FiltersViewController
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupNavBar()
    self.setupSwitches()
    self.updateFilters()
  }
  
  private func setupNavBar() {
    self.navigationItem.title = "Filters"
    if let closeImage = UIImage(named: "Close")?.maskedImageWithColor(UIColor.lightAccent) {
      let closeButton = UIButton(type: .custom)
      closeButton.addTarget(self, action: #selector(closeTapped(_:)), for: .touchUpInside)
      closeButton.setImage(closeImage, for: .normal)
      closeButton.frame = CGRect(x: 0, y: 0, width: closeImage.size.width, height: closeImage.size.height)
      let closeItem = UIBarButtonItem(customView: closeButton)
      
      self.navigationItem.rightBarButtonItems = [closeItem]
    }
  }
  
  private func setupSwitches() {
    self.sponsorSwitch.tintColor = UIColor.sponsorBold
    self.sponsorSwitch.onTintColor = self.sponsorSwitch.tintColor
    self.foodSwitch.tintColor = UIColor.foodBold
    self.foodSwitch.onTintColor = self.foodSwitch.tintColor
    self.exhibitSwitch.tintColor = UIColor.exhibitBold
    self.exhibitSwitch.onTintColor = self.exhibitSwitch.tintColor
  }
  
  func updateFilters() {
    let filters = Filters.shared
    self.sponsorSwitch.isOn = filters.showSponsor
    self.foodSwitch.isOn = filters.showFood
    self.exhibitSwitch.isOn = filters.showExhibit
  }
  
  // MARK: Actions
  
  @IBAction func sponsorTapped(_ sender: AnyObject) {
    let s = sender as! UISwitch
    Filters.shared.showSponsor = s.isOn
    Filters.shared.saveFilters()
  }
  
  @IBAction func foodTapped(_ sender: AnyObject) {
    let s = sender as! UISwitch
    Filters.shared.showFood = s.isOn
    Filters.shared.saveFilters()
  }
  
  @IBAction func exhibitTapped(_ sender: AnyObject) {
    let s = sender as! UISwitch
    Filters.shared.showExhibit = s.isOn
    Filters.shared.saveFilters()
  }
  
  @IBAction func closeTapped(_ sender: AnyObject) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
