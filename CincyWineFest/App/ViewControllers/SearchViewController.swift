//
//  SearchViewController.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import UIKit

// MARK: Constants

let SearchViewId = "SearchViewId"

class SearchViewController: BaseViewController {
  
  // MARK: Properties
  
  @IBOutlet var searchIcon: UIImageView!
  @IBOutlet var searchTextField: UITextField!
  @IBOutlet var searchTable: UITableView!
  @IBOutlet var searchTableBottomConstraint: NSLayoutConstraint!
  
  let searchManager = SearchManager()
  
  // MARK: Init
  
  class func createController() -> SearchViewController {
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController: SearchViewController = storyboard.instantiateViewController(withIdentifier: SearchViewId) as! SearchViewController
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.searchIcon.image = self.searchIcon.image?.maskedImageWithColor(UIColor(hex: 0xc7c7cd))
    self.searchTextField.becomeFirstResponder()
    self.setupNavBar()
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  private func setupNavBar() {
    // TODO: Future - Rethink how to implement the close button
    //    if let closeImage = UIImage(named: "Close")?.maskedImageWithColor(UIColor.accent) {
    //      let closeButton = UIButton(type: .custom)
    //      closeButton.addTarget(self, action: #selector(closeTapped(_:)), for: .touchUpInside)
    //      closeButton.setImage(closeImage, for: .normal)
    //      closeButton.frame = CGRect(x: 0, y: 0, width: closeImage.size.width, height: closeImage.size.height)
    //      let closeItem = UIBarButtonItem(customView: closeButton)
    //
    //      self.navigationItem.rightBarButtonItems = [closeItem]
    //    }
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: Actions
  
  @IBAction func closeTapped(_ sender: AnyObject) {
    self.view.endEditing(true)
  }
  
  // MARK: Notifications
  
  @objc func handleKeyboardWillShowNotification(_ notification: Notification) {
    let userInfo = (notification as NSNotification).userInfo!
    let kbSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
    let duration: NSNumber = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber)
    
    UIView.animate(withDuration: TimeInterval(truncating: duration), animations: {
      var tabBarHeight: CGFloat = 0
      if let calculatedTabHeight = self.tabBarController?.tabBar.bounds.size.height {
        tabBarHeight = calculatedTabHeight
      }
      self.searchTableBottomConstraint.constant = kbSize.height - tabBarHeight
      self.view.layoutIfNeeded()
    })
  }
  
  @objc func handleKeyboardWillHideNotification(_ notification: Notification) {
    let userInfo = (notification as NSNotification).userInfo!
    let duration: NSNumber = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber)
    
    UIView.animate(withDuration: TimeInterval(truncating: duration), animations: {
      self.searchTableBottomConstraint.constant = 0
      self.view.layoutIfNeeded()
    })
  }
  
}

extension SearchViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let updatedString = textField.text!.replacingCharacters(in: range.toRange(textField.text!), with: string) as String
    self.searchManager.performSearch(for: updatedString)
    self.searchTable.reloadData()
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return true
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    self.searchManager.clearData()
    self.searchTable.reloadData()
    return true
  }
  
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
  
  // MARK: UITableViewDataSource
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 6
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return self.searchManager.wineries.count
    }
    else if section == 1 {
      return self.searchManager.wines.count
    }
    else if section == 2 {
      return self.searchManager.countries.count
    }
    else if section == 3 {
      return self.searchManager.goldMedals.count
    }
    else if section == 4 {
      return self.searchManager.silverMedals.count
    } else {
      return self.searchManager.bronzeMedals.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var curWine = Wine()
    
    if (indexPath.section == 0) {
      curWine = self.searchManager.wineries[indexPath.row]
    }
    else if (indexPath.section == 1) {
      curWine = self.searchManager.wines[indexPath.row]
    }
    else if (indexPath.section == 2) {
      curWine = self.searchManager.countries[indexPath.row]
    }
    else if (indexPath.section == 3) {
      curWine = self.searchManager.goldMedals[indexPath.row]
    }
    else if (indexPath.section == 4) {
      curWine = self.searchManager.silverMedals[indexPath.row]
    }
    else if (indexPath.section == 5) {
      curWine = self.searchManager.bronzeMedals[indexPath.row]
    }
    let wineCell: WineCell = tableView.dequeueReusableCell(withIdentifier: WineCellId, for: indexPath as IndexPath) as! WineCell
    wineCell.layoutFor(wine: curWine)
    wineCell.delegate = self
    
    return wineCell
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return WineListViewCellHeight
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    var result: String?
    
    if (section == 0 && self.searchManager.wineries.count > 0) {
      result = "Booths"
    }
    else if (section == 1 && self.searchManager.wines.count > 0) {
      result = "Wines"
    }
    else if (section == 2 && self.searchManager.countries.count > 0) {
      result = "Countries"
    }
    else if (section == 3 && self.searchManager.goldMedals.count > 0) {
      result = "Gold Medals"
    }
    else if (section == 4 && self.searchManager.silverMedals.count > 0) {
      result = "Silver Medals"
    }
    else if (section == 5 && self.searchManager.bronzeMedals.count > 0) {
      result = "Bronze Medals"
    }
    
    return result
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var curWine: Wine?
    
    if (indexPath.section == 0) {
      curWine = self.searchManager.wineries[indexPath.row]
    }
    else if (indexPath.section == 1) {
      curWine = self.searchManager.wines[indexPath.row]
    }
    else if (indexPath.section == 2) {
      curWine = self.searchManager.countries[indexPath.row]
    }
    else if (indexPath.section == 3) {
      curWine = self.searchManager.goldMedals[indexPath.row]
    }
    else if (indexPath.section == 4) {
      curWine = self.searchManager.silverMedals[indexPath.row]
    }
    else if (indexPath.section == 5) {
      curWine = self.searchManager.bronzeMedals[indexPath.row]
    }
    
    if let curWine = curWine {
      let wineController = WineViewController.createControllerFor(wine: curWine)
      self.navigationController?.pushViewController(wineController, animated: true)
    } else {
      let alert = UIAlertController(title: "Error Loading Wine", message: "Sorry! We were unable to find information on this wine.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }
  
}

extension SearchViewController: WineCellDelegate {
  
  func wineTastedWasToggled(_ wine: Wine, tasted: Bool, forCell: WineCell) {
    wine.toggleTasted()
    self.searchTable.reloadData()
  }
  
  func wineFavoriteWasToggled(_ wine: Wine, favorited: Bool, forCell: WineCell) {
    wine.toggleFavorited()
    self.searchTable.reloadData()
  }
  
}
