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
  @IBOutlet var boothLabel: RegularLabel!
  @IBOutlet var separatorVerticalConstraint: NSLayoutConstraint!
  @IBOutlet var boothLabelVerticalConstraint: NSLayoutConstraint!
  @IBOutlet var starOne: UIButton!
  @IBOutlet var starTwo: UIButton!
  @IBOutlet var starThree: UIButton!
  @IBOutlet var starFour: UIButton!
  @IBOutlet var starFive: UIButton!
  @IBOutlet var noteField: UITextView!
  @IBOutlet var addNoteLabel: RegularLabel!
  @IBOutlet var rateLabel: RegularLabel!
  @IBOutlet var photoButton: UIButton!
  
  var wine: Wine!
  
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
    styleTextView()
    stylePhotoButton()
    updateNote()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    if UIScreen.uiKitScreenSize == iPhone678Size {
      if self.nameLabel.bounds.size.height > 92 {
        self.nameLabel.minimumScaleFactor = 0.5
        self.nameLabel.text = self.wine.name
      }
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(animated)
    addNote()
  }
  
  private func styleTextView() {
    self.noteField.layer.borderColor = UIColor.mediumText.cgColor
    self.noteField.layer.borderWidth = 0.5
    self.noteField.layer.cornerRadius = 6.0
  }
  
  private func stylePhotoButton() {
    self.noteField.layer.borderWidth = 0.5
    self.noteField.layer.cornerRadius = 6.0
  }
  
  private func setupForWine() {
    if self.wine.boothType == .wine {
      self.nameLabel.text = "\(self.wine.vintage) \(self.wine.formattedName)"
      self.wineryLabel.text = self.wine.winery
    }
    else {
      self.favoriteButton.isHidden = true
      self.tastedButton.isHidden = true
      self.countryLabel.isHidden = true
      self.boothLabelVerticalConstraint.constant = 8
      self.separatorVerticalConstraint.constant = 8
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
    
    if self.wine.boothNumber > 0 {
      self.boothLabel.text = "Booth \(self.wine.boothNumber)"
    } else {
      if self.wine.boothNumber == SpecialBoothType.HC.rawValue {
        self.boothLabel.text = "Booth HC"
      }
      else if self.wine.boothNumber == SpecialBoothType.BottomLeft.rawValue {
        self.boothLabel.text = "Bottom Left"
      } else {
        self.boothLabel.text = "Bottom Right"
      }
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
    
    if wine.photo != nil {
      photoButton.setImage(wine.photo, for: .normal)
    }
    
    self.updateButtons()
  }

  private func addNote() {
    let stars = [starOne, starTwo, starThree, starFour, starFive]
    var count = 0
    for curStar in stars {
      if curStar?.image(for: .normal) == UIImage(named: "StarFilled") {
        count += 1
      }
    }
    if count > 0 {
      wine.addRating(rating: count)
    }
    
    if !noteField.text.isEmpty {
      wine.addNote(note: noteField.text)
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
  
  @IBAction func starTapped(_ sender: AnyObject) {
    if let button = sender as? UIButton {
      let rating = button.tag
      updateStarsFor(rating: rating)
    }
  }
  
  @IBAction func noteTapped(_ sender: AnyObject) {
    let alert = UIAlertController(title: "Notes", message: "\n\n", preferredStyle: .alert)
    alert.view.autoresizesSubviews = true
    
    let textView = KMPlaceholderTextView(frame: CGRect.zero)
    textView.text = wine.note
    textView.placeholder = "Enter notes"
    textView.layer.borderColor = UIColor.mediumText.cgColor
    textView.layer.borderWidth = 0.5
    textView.layer.cornerRadius = 6.0
    textView.translatesAutoresizingMaskIntoConstraints = false
    
      let leadConstraint = NSLayoutConstraint(item: alert.view as Any, attribute: .leading, relatedBy: .equal, toItem: textView, attribute: .leading, multiplier: 1.0, constant: -8.0)
      let trailConstraint = NSLayoutConstraint(item: alert.view as Any, attribute: .trailing, relatedBy: .equal, toItem: textView, attribute: .trailing, multiplier: 1.0, constant: 8.0)
    
      let topConstraint = NSLayoutConstraint(item: alert.view as Any, attribute: .top, relatedBy: .equal, toItem: textView, attribute: .top, multiplier: 1.0, constant: -10.0)
      let bottomConstraint = NSLayoutConstraint(item: alert.view as Any, attribute: .bottom, relatedBy: .equal, toItem: textView, attribute: .bottom, multiplier: 1.0, constant: 64.0)
    alert.view.addSubview(textView)
    NSLayoutConstraint.activate([leadConstraint, trailConstraint, topConstraint, bottomConstraint])
    let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
      self.wine.note = textView.text
      self.updateNote()
    }
    alert.addAction(saveAction)
    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    alert.addAction(cancelAction)
    self.present(alert, animated: true) {
      textView.becomeFirstResponder()
    }
  }
  
  @IBAction func photoTapped(_ sender: AnyObject) {
    if wine.photo == nil {
      let imagePicker = UIImagePickerController()
      imagePicker.sourceType = .camera
      imagePicker.delegate = self
      self.present(imagePicker, animated: true, completion: nil)
    } else {
      let photoController = PhotoViewController.createControllerForWine(wine: wine)
      let navController = BaseNavigationController(rootViewController: photoController)
      self.present(navController, animated: true, completion: nil)
    }
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
  
  private func updateStarsFor(rating: Int) {
    let stars = [starOne, starTwo, starThree, starFour, starFive]
    for i in 0..<rating {
      stars[i]?.setImage(UIImage(named: "StarFilled"), for: .normal)
    }
    for i in rating..<stars.count {
      stars[i]?.setImage(UIImage(named: "StarOutline"), for: .normal)
    }
  }
  
  private func updateNote() {
    if wine.rating > -1 {
      updateStarsFor(rating: wine.rating)
    }
    
    noteField.text = wine.note
  }
  
}

extension WineViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    picker.dismiss(animated: true)
      wine.photo = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
    photoButton.setImage(wine.photo, for: .normal)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
