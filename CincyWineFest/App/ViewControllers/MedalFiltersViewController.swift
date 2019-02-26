//
//  MedalFiltersViewController.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/26/19.
//  Copyright © 2019 zigabytes. All rights reserved.
//

import UIKit

// MARK: - Constants

let MedalFiltersViewId = "MedalFiltersViewId"

class MedalFiltersViewController: BaseViewController {

  // MARK: - Properties
  
  @IBOutlet var allImageView: UIImageView!
  @IBOutlet var goldImageView: UIImageView!
  @IBOutlet var silverImageView: UIImageView!
  @IBOutlet var bronzeImageView: UIImageView!
  
  // MARK: - Init
  
  class func createController() -> MedalFiltersViewController {
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController: MedalFiltersViewController = storyboard.instantiateViewController(withIdentifier: MedalFiltersViewId) as! MedalFiltersViewController
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupNavBar()
    self.updateCheckmark()
  }
  
  private func setupNavBar() {
    self.navigationItem.title = "Medal Filters"
    if let closeImage = UIImage(named: "Close")?.maskedImageWithColor(UIColor.lightAccent) {
      let closeButton = UIButton(type: .custom)
      closeButton.addTarget(self, action: #selector(closeTapped(_:)), for: .touchUpInside)
      closeButton.setImage(closeImage, for: .normal)
      closeButton.frame = CGRect(x: 0, y: 0, width: closeImage.size.width, height: closeImage.size.height)
      let closeItem = UIBarButtonItem(customView: closeButton)
      
      self.navigationItem.rightBarButtonItems = [closeItem]
    }
  }
  
  // MARK: - Actions
  
  @IBAction func allTapped(_ sender: AnyObject) {
    Filters.shared.medalFilter = .allWines
    Filters.shared.saveFilters()
    self.updateCheckmark()
  }
  
  @IBAction func goldTapped(_ sender: AnyObject) {
    Filters.shared.medalFilter = .gold
    Filters.shared.saveFilters()
    self.updateCheckmark()
  }
  
  @IBAction func silverTapped(_ sender: AnyObject) {
    Filters.shared.medalFilter = .silver
    Filters.shared.saveFilters()
    self.updateCheckmark()
  }
  
  @IBAction func bronzeTapped(_ sender: AnyObject) {
    Filters.shared.medalFilter = .bronze
    Filters.shared.saveFilters()
    self.updateCheckmark()
  }
  
  @IBAction func closeTapped(_ sender: AnyObject) {
    self.dismiss(animated: true, completion: nil)
  }
  
  // MARK: - Convenience Methods
  
  private func updateCheckmark() {
    let filters = Filters.shared
    switch filters.medalFilter {
    case .allWines:
      self.allImageView.image = UIImage(named: "TastedFilled")?.maskedImageWithColor(UIColor.lightAccent)
      self.goldImageView.image = nil
      self.silverImageView.image = nil
      self.bronzeImageView.image = nil
      break
    case .gold:
      self.allImageView.image = nil
      self.goldImageView.image = UIImage(named: "TastedFilled")?.maskedImageWithColor(UIColor.goldAccent)
      self.silverImageView.image = nil
      self.bronzeImageView.image = nil
      break
    case .silver:
      self.allImageView.image = nil
      self.goldImageView.image = nil
      self.silverImageView.image = UIImage(named: "TastedFilled")?.maskedImageWithColor(UIColor.silverAccent)
      self.bronzeImageView.image = nil
      break
    case .bronze:
      self.allImageView.image = nil
      self.goldImageView.image = nil
      self.silverImageView.image = nil
      self.bronzeImageView.image = UIImage(named: "TastedFilled")?.maskedImageWithColor(UIColor.bronzeAccent)
      break
    }
  }
  
}
