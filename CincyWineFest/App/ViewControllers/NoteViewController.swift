//
//  NoteViewController.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import UIKit

// MARK: Constants

let NoteViewId = "NoteViewId"

class NoteViewController: BaseViewController {
  
  @IBOutlet var wineLabel: UILabel!
  @IBOutlet var starOne: UIButton!
  @IBOutlet var starTwo: UIButton!
  @IBOutlet var starThree: UIButton!
  @IBOutlet var starFour: UIButton!
  @IBOutlet var starFive: UIButton!
  @IBOutlet var noteField: UITextView!
  @IBOutlet var addNoteButton: UIButton!
  @IBOutlet var noteFieldBottomConstraint: NSLayoutConstraint!
  
  var wine: Wine!
  
  // MARK: Init
  
  class func createControllerFor(wine: Wine) -> NoteViewController {
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController: NoteViewController = storyboard.instantiateViewController(withIdentifier: NoteViewId) as! NoteViewController
    viewController.wine = wine
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    wineLabel.text = "\(self.wine.vintage) \(self.wine.formattedName)"
    registerForNotifications()
    styleTextView()
    setupNavBar()
    updateNote()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    self.addNote()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  private func registerForNotifications() {
      NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  private func styleTextView() {
    self.noteField.layer.borderColor = UIColor.mediumText.cgColor
    self.noteField.layer.borderWidth = 0.5
    self.noteField.layer.cornerRadius = 6.0
  }
  
  private func setupNavBar() {
    let noteButton = UIButton(type: .custom)
    noteButton.addTarget(self, action: #selector(saveTapped(_:)), for: .touchUpInside)
    noteButton.setTitle("Save", for: .normal)
    noteButton.setTitleColor(UIColor.lightAccent, for: .normal)
    let noteItem = UIBarButtonItem(customView: noteButton)
    
    self.navigationItem.rightBarButtonItems = [noteItem]
  }
  
  private func updateNote() {
    if wine.rating > -1 {
      updateStarsFor(rating: wine.rating)
    }
    
    noteField.text = wine.note
    noteField.becomeFirstResponder()
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
  
  // MARK: Actions
  
  @IBAction func starTapped(_ sender: AnyObject) {
    if let button = sender as? UIButton {
      let rating = button.tag
      updateStarsFor(rating: rating)
    }
  }
  
  @IBAction func saveTapped(_ sender: AnyObject) {
    self.addNote()
    self.navigationController?.popViewController(animated: true)
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
  
  // MARK: Notifications
  
  @objc func handleKeyboardWillShowNotification(_ notification: Notification) {
    let userInfo = (notification as NSNotification).userInfo!
      let kbSize = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
      let duration: NSNumber = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber)
    
    UIView.animate(withDuration: TimeInterval(truncating: duration), animations: {
      self.noteFieldBottomConstraint.constant = kbSize.height
      self.view.layoutIfNeeded()
    })
  }
  
  @objc func handleKeyboardWillHideNotification(_ notification: Notification) {
    let userInfo = (notification as NSNotification).userInfo!
      let duration: NSNumber = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber)
    
    UIView.animate(withDuration: TimeInterval(truncating: duration), animations: {
      self.noteFieldBottomConstraint.constant = 0
      self.view.layoutIfNeeded()
    })
  }
  
}

