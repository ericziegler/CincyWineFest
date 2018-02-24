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
  @IBOutlet weak var flag1ImageView: UIImageView!
  @IBOutlet weak var flag2ImageView: UIImageView!
  @IBOutlet weak var flag3ImageView: UIImageView!
  @IBOutlet weak var flag4ImageView: UIImageView!
  @IBOutlet weak var tastedButton: UIButton!
  @IBOutlet weak var favoriteButton: UIButton!
  
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
    
    self.wineryLabel.text = "\(wine.boothNumber) - \(wine.winery)"
    self.nameLabel.text = "\(wine.vintage) \(wine.name)"
    
    for i in 0..<4 {
      if wine.countries.count < i {
        var imageView: UIImageView = self.flag1ImageView
        if i == 3 {
          imageView = self.flag4ImageView
        }
        else if i == 2 {
          imageView = self.flag3ImageView
        }
        else if i == 1 {
          imageView = self.flag2ImageView
        }
        imageView.image = wine.countries[i].flag
      }
    }
    
    self.medalImageView.image = wine.medal.image
    
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
