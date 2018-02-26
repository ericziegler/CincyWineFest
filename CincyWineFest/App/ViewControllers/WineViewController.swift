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
  @IBOutlet var mapView: UIScrollView!
  @IBOutlet weak var medalImageView: UIImageView!
  @IBOutlet var medalLabel: UILabel!
  @IBOutlet var flag0Button: UIButton!
  @IBOutlet var flag1Button: UIButton!
  @IBOutlet var flag2Button: UIButton!
  @IBOutlet var flag3Button: UIButton!
  @IBOutlet var flag4Button: UIButton!
  @IBOutlet var favoriteButton: UIButton!
  @IBOutlet var tastedButton: UIButton!
  @IBOutlet var mapTapGestureRecognizer: UITapGestureRecognizer!
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
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.updateCommentPlaceholder()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.scrollToLocation()
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
    var point = CGPoint.zero
    
    if let location = self.wine.mapLocation {
      if location == "0" {
        point = CGPoint(x: 0, y: 0)
      }
      else if location == "1" {
        point = CGPoint(x: 0, y: 425)
      }
      else if location == "2" {
        point = CGPoint(x: 140, y: 0)
      }
      else if location == "3" {
        point = CGPoint(x: 140, y: 425)
      }
      else if location == "4" {
        point = CGPoint(x: 415, y: 0)
      }
      else if location == "5" {
        point = CGPoint(x: 415, y: 400)
      }
      else if location == "6" {
        point = CGPoint(x: 540, y: 0)
      }
      else if location == "7" {
        point = CGPoint(x: 540, y: 425)
      }
      let rect = CGRect(x: point.x, y: point.y, width: point.x + 200, height: point.y + 200)
      self.mapView.zoom(to: rect, animated: false)
    }
  }
  
  private func styleMap() {
    self.mapView.layer.borderColor = UIColor.mediumText.cgColor
    self.mapView.layer.borderWidth = 0.5
    
    self.mapImageView = UIImageView(image: UIImage(named: "FloorMap"))
    self.mapView.addSubview(self.mapImageView)
    self.mapView.contentSize = self.mapImageView.bounds.size
    self.mapView.clipsToBounds = true
    self.mapView.maximumZoomScale = 2.5
    
    self.mapTapGestureRecognizer.numberOfTapsRequired = 2
  }
  
  @IBAction func mapTapped(_ sender: UITapGestureRecognizer) {
    let point = sender.location(in: self.mapImageView)
    self.zoomToPoint(point: point)
  }
  
  private func zoomToPoint(point: CGPoint) {
    let scale = min(self.mapView.zoomScale * 2, self.mapView.maximumZoomScale)
    if scale != self.mapView.zoomScale {
      let scrollSize = self.mapView.frame.size
      let size = CGSize(width: scrollSize.width / scale,
                        height: scrollSize.height / scale)
      let origin = CGPoint(x: point.x - size.width / 2,
                           y: point.y - size.height / 2)
      self.mapView.zoom(to:CGRect(origin: origin, size: size), animated: true)
    }
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

extension WineViewController: UIScrollViewDelegate {
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.mapImageView
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print(scrollView.contentOffset)
  }
  
}
