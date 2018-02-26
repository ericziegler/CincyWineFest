//
//  WineCell.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import UIKit

// MARK: Constants

let WineCellId = "WineCellId"
let WineListViewCellHeight: CGFloat = 66.0
let NameLabelLeadingConstraintClose: CGFloat = 8.0
let NameLabelLeadingConstraintFar: CGFloat = 36.0

// MARK: Protocol

protocol WineCellDelegate {
  func wineTastedWasToggled(_ wine: Wine, tasted: Bool, forCell: WineCell)
  func wineFavoriteWasToggled(_ wine: Wine, favorited: Bool, forCell: WineCell)
}

class WineCell: UITableViewCell {
  
  // MARK: Properties
  
  @IBOutlet weak var wineryLabel: RegularLabel!
  @IBOutlet weak var nameLabel: LightLabel!
  @IBOutlet weak var medalImageView: UIImageView!
  @IBOutlet weak var tastedButton: UIButton!
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var wineLeadingConstraint: NSLayoutConstraint!
  
  var wine: Wine?
  var delegate: WineCellDelegate?
  
  // MARK: Actions
  
  @IBAction func tastedTapped(_ sender: AnyObject) {
    if let b = self.wine, let d = self.delegate {
      d.wineTastedWasToggled(b, tasted: !b.hasTasted, forCell: self)
    }
  }
  
  @IBAction func favoriteTapped(_ sender: AnyObject) {
    if let b = self.wine, let d = self.delegate {
      d.wineFavoriteWasToggled(b, favorited: !b.isFavorited, forCell: self)
    }
  }
  
  // MARK: Layout
  
  func layoutFor(wine: Wine) {
    self.wine = wine
    
    if wine.boothNumber > 0 {
      self.wineryLabel.text = "\(wine.boothNumber) - \(wine.winery)"
    } else {
      self.wineryLabel.text = wine.winery
    }
    
    if wine.boothType == .wine {
      self.nameLabel.text = "\(wine.vintage) \(wine.formattedName)"
      self.favoriteButton.isHidden = false
      self.tastedButton.isHidden = false
      self.nameLabel.textColor = UIColor.mediumText
    } else {
      self.favoriteButton.isHidden = true
      self.tastedButton.isHidden = true
      self.nameLabel.textColor = UIColor.darkText
      self.wineryLabel.textColor = UIColor.darkText
      if wine.boothType == .food {
        self.nameLabel.text = "(Food Booth)"
      }
      else if wine.boothType == .exhibit {
        self.nameLabel.text = "(Exhibitors)"
      }
      else if wine.boothType == .sponsor {
        self.nameLabel.text = "(Event Sponsor)"
      }
    }
    
    self.medalImageView.image = wine.medal.image
    self.wineLeadingConstraint.constant = (self.medalImageView.image == nil) ? NameLabelLeadingConstraintClose : NameLabelLeadingConstraintFar
    
    if (wine.isFavorited) {
      self.favoriteButton.setImage(UIImage(named: "FavoriteFilled"), for: .normal)
    } else {
      self.favoriteButton.setImage(UIImage(named: "FavoriteOutline"), for: .normal)
    }
    
    if (wine.hasTasted) {
      self.tastedButton.setImage(UIImage(named: "TastedFilled"), for: .normal)
    } else {
      self.tastedButton.setImage(UIImage(named: "TastedOutline"), for: .normal)
    }
    
    self.backgroundColor = wine.boothType.color
  }
  
}
