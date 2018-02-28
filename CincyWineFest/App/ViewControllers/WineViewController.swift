//
//  WineViewController.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import UIKit

// MARK: Constants

let WineViewId = "WineViewId"

class WineViewController: BaseViewController {
  
  // MARK: Properties
  
  @IBOutlet var nameLabel: RegularLabel!
  @IBOutlet var wineryLabel: RegularLabel!
  @IBOutlet var mapView: GTZoomableImageView!
  @IBOutlet weak var medalImageView: UIImageView!
  @IBOutlet var medalLabel: UILabel!
  @IBOutlet var flag0Button: UIButton!
  @IBOutlet var flag1Button: UIButton!
  @IBOutlet var flag2Button: UIButton!
  @IBOutlet var flag3Button: UIButton!
  @IBOutlet var flag4Button: UIButton!
  @IBOutlet var favoriteButton: UIButton!
  @IBOutlet var tastedButton: UIButton!
  @IBOutlet var countryLabel: RegularLabel!
  @IBOutlet var commentView: UIView!
  @IBOutlet var commentLabel: UILabel!
  
  var wine: Wine!
  var mapImageView: UIImageView!
  
  // MARK: Init
  
  class func createControllerFor(wine: Wine) -> WineViewController {
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController: WineViewController = storyboard.instantiateViewController(withIdentifier: WineViewId) as! WineViewController
    viewController.wine = wine
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupForWine()
    self.styleMap()
    self.styleCommentBar()
    self.scrollToLocation()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.updateCommentPlaceholder()
  }
  
  private func setupForWine() {
    if self.wine.boothType == .wine {
      self.nameLabel.text = "\(self.wine.vintage) \(self.wine.formattedName)"
      if self.wine.boothNumber > 0 {
        self.wineryLabel.text = "\(self.wine.boothNumber) - \(self.wine.winery)"
      } else {
        self.wineryLabel.text = self.wine.winery
      }
    }
    else {
      self.favoriteButton.isHidden = true
      self.tastedButton.isHidden = true
      self.commentView.isHidden = true
      self.countryLabel.isHidden = true
      self.nameLabel.text = self.wine.winery
      if self.wine.boothType == .exhibit {
        self.wineryLabel.text = "(Exhibitor)"
      }
      else if self.wine.boothType == .food {
        self.wineryLabel.text = "(Food Booth)"
      }
      else if self.wine.boothType == .sponsor {
        self.wineryLabel.text = "(Event Sponsor)"
      }
    }
    self.medalImageView.image = self.wine.medal.image
    
    if self.wine.medal == .gold {
      self.medalLabel.text = "Gold Medal Winner"
    }
    else if self.wine.medal == .silver {
      self.medalLabel.text = "Silver Medal Winner"
    }
    else if self.wine.medal == .bronze {
      self.medalLabel.text = "Bronze Medal Winner"
    } else {
      self.medalLabel.text = nil
    }
    
    for i in 0..<self.wine.countries.count {
      var button: UIButton = self.flag0Button
      if i == 4 {
        button = self.flag4Button
      }
      else if i == 3 {
        button = self.flag3Button
      }
      else if i == 2 {
        button = self.flag2Button
      }
      else if i == 1 {
        button = self.flag1Button
      }
      button.setImage(self.wine.countries[i].flag, for: .normal)
    }
    
    self.updateButtons()
  }
  
  private func styleCommentBar() {
    self.commentView.layer.borderColor = UIColor.mediumText.cgColor
    self.commentView.layer.borderWidth = 0.5
    self.commentView.layer.cornerRadius = 6.0
  }
  
  private func updateCommentPlaceholder() {
    if wine.rating > -1 || !wine.note.isEmpty {
      self.commentLabel.text = "Update note/rating for this wine"
    } else {
      self.commentLabel.text = "Add note/rating for this wine"
    }
  }
  
  private func scrollToLocation() {
    let yourDelay = 0.4
    let yourDuration = 0.3
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + yourDelay, execute: { () -> Void in
      UIView.animate(withDuration: yourDuration, animations: { () -> Void in
        //var point = CGPoint.zero
        var rect = CGRect.zero
        var mapBounds = CGSize.zero
        
        if UIScreen.uiKitScreenSize == iPhoneSESize {
          
        }
        else if UIScreen.uiKitScreenSize == iPhone678Size {
          
        }
        else if UIScreen.uiKitScreenSize == iPhone678PlusSize {
          mapBounds = CGSize(width: 136, height: 83)
          if self.boothInRange(min: 119, max: 124) || self.boothInRange(min: 86, max: 88) ||
            self.boothInRange(min: 101, max: 103) || self.boothInRange(min: 131, max: 131) {
            rect = CGRect(x: 0, y: 0, width: mapBounds.width, height: mapBounds.height)
          }
          else if self.boothInRange(min: 125, max: 130) || self.boothInRange(min: 114, max: 118) ||
            self.boothInRange(min: 101, max: 103) || self.boothInRange(min: 107, max: 111) ||
            self.boothInRange(min: 96, max: 100) || self.boothInRange(min: 89, max: 93) {
            rect = CGRect(x: 0, y: 83, width: mapBounds.width, height: mapBounds.height)
          }
          else if self.boothInRange(min: 112, max: 113) || self.boothInRange(min: 94, max: 95) ||
            self.boothInRange(min: 138, max: 138) {
            rect = CGRect(x: 0, y: 150, width: mapBounds.width, height: mapBounds.height)
          }
          else if self.boothInRange(min: 83, max: 85) || self.boothInRange(min: 65, max: 70) ||
            self.boothInRange(min: 53, max: 58) || self.boothInRange(min: 44, max: 46) ||
            self.boothInRange(min: 132, max: 134) {
            rect = CGRect(x: 122, y: 3, width: mapBounds.width, height: mapBounds.height)
          }
          else if self.boothInRange(min: 71, max: 75) || self.boothInRange(min: 78, max: 82) ||
            self.boothInRange(min: 47, max: 52) || self.boothInRange(min: 59, max: 64) {
            rect = CGRect(x: 122, y: 82, width: mapBounds.width, height: mapBounds.height)
          }
          else if self.boothInRange(min: 76, max: 77) || self.boothInRange(min: 0, max: 0) {
            rect = CGRect(x: 127, y: 150, width: mapBounds.width, height: mapBounds.height)
          }
          else if self.boothInRange(min: 23, max: 28) || self.boothInRange(min: 41, max: 43) ||
            self.boothInRange(min: 7, max: 12) || self.boothInRange(min: 135, max: 137) {
            rect = CGRect(x: 245, y: 2, width: mapBounds.width, height: mapBounds.height)
          }
          else if self.boothInRange(min: 1, max: 6) || self.boothInRange(min: 13, max: 17) ||
          self.boothInRange(min: 13, max: 22) || self.boothInRange(min: 29, max: 33) ||
            self.boothInRange(min: 36, max: 40) {
            rect = CGRect(x: 246, y: 83, width: mapBounds.width, height: mapBounds.height)
          }
          else if self.boothInRange(min: 34, max: 35) {
            rect = CGRect(x: 244, y: 150, width: mapBounds.width, height: mapBounds.height)
          }
        }
        else if UIScreen.uiKitScreenSize == iPhoneXSize {
          
        }
        if rect != CGRect.zero {
          self.mapView.zoomIn(rect: rect)
        }
      })
    })
  }
  
  private func styleMap() {
    self.mapView.layer.borderColor = UIColor.mediumText.cgColor
    self.mapView.layer.borderWidth = 0.5
    
    self.mapView.image = UIImage(named: "FloorMap")
  }

  private func updateButtons() {
    if self.wine.isFavorited {
      self.favoriteButton.setImage(UIImage(named: "FavoriteFilled"), for: .normal)
    } else {
      self.favoriteButton.setImage(UIImage(named: "FavoriteOutline"), for: .normal)
    }
    
    if self.wine.hasTasted {
      self.tastedButton.setImage(UIImage(named: "TastedFilled"), for: .normal)
    } else {
      self.tastedButton.setImage(UIImage(named: "TastedOutline"), for: .normal)
    }
  }
  
  private func boothInRange(min: Int, max: Int) -> Bool {
    if self.wine.boothNumber <= max && self.wine.boothNumber >= min {
      return true
    }
    return false
  }
  
  // MARK: Actions
  
  @IBAction func favoriteTapped(_ sender: AnyObject) {
    wine.toggleFavorited()
    WineList.shared.saveWinesToCache()
    self.updateButtons()
  }
  
  @IBAction func tastedTapped(_ sender: AnyObject) {
    wine.toggleTasted()
    WineList.shared.saveWinesToCache()
    self.updateButtons()
  }
  
  @IBAction func commentTapped(_ sender: AnyObject) {
    let commentViewController = CommentViewController.createControllerFor(wine: wine)
    self.navigationController?.pushViewController(commentViewController, animated: true)
  }
  
  @IBAction func flagTapped(_ sender: AnyObject) {
    if let button = sender as? UIButton {
      if button.tag >= 0 && button.tag < self.wine.countries.count {
        let country = self.wine.countries[button.tag]
        let alert = UIAlertController(title: self.wine.winery, message: "This booth pours wine from \(country.formattedName)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    }
  }
  
}
