//
//  WineListViewController.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import UIKit

// MARK: Constants

let WineListViewId = "WineListViewId"
let TastedListViewId = "TastedListViewId"
let FavoriteListViewId = "FavoriteListViewId"

enum WineListType: Int {
  
  case fullList
  case tasted
  case favorites
  
}

class WineListViewController: BaseTableViewController {
  
  // MARK: Properties
  
  var listType = WineListType.fullList
  let sectionTitles = ["#", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
  
  // MARK: Init
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let storyboardId = self.restorationIdentifier {
      if storyboardId == TastedListViewId {
        self.listType = .tasted
      }
      else if storyboardId == FavoriteListViewId {
        self.listType = .favorites
      }
    }
    self.setupNavBar()
    
    self.view.backgroundColor = UIColor.mainBackground
    self.tableView.sectionIndexBackgroundColor = UIColor.clear
    self.tableView.sectionIndexColor = UIColor.accent
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if (self.listType == .fullList) {
      AlphabeticalWineList.shared.alphabetizeWines()
    }
    self.tableView.reloadData()
  }
  
  private func setupNavBar() {
    if self.listType == .fullList {
      self.navigationItem.title = "Winefest".uppercased()
      if let filterImage = UIImage(named: "Filter")?.maskedImageWithColor(UIColor.lightAccent) {
        let filterButton = UIButton(type: .custom)
        filterButton.addTarget(self, action: #selector(filterTapped(_:)), for: .touchUpInside)
        filterButton.setImage(filterImage, for: .normal)
        filterButton.frame = CGRect(x: 0, y: 0, width: filterImage.size.width, height: filterImage.size.height)
        let filterItem = UIBarButtonItem(customView: filterButton)
        
        self.navigationItem.rightBarButtonItems = [filterItem]
      }
    }
  }
  
  // MARK: Actions
  
  @IBAction func filterTapped(_ sender: AnyObject) {
    let filtersVC = FiltersViewController.createController()
    let navController = BaseNavigationController(rootViewController: filtersVC)
    self.present(navController, animated: true, completion: nil)
  }
  
  // MARK: UITableViewDataSource
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    if (self.listType == .fullList) {
      return AlphabeticalWineList.shared.wines.keys.count
    } else {
      return 1
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (self.listType == .fullList) {
      let key = AlphabeticalWineList.shared.sortedKeys[section]
      return AlphabeticalWineList.shared.wines[key]!.count
      
    }
    else if (self.listType == .tasted) {
      return TastedWineList.shared.wines.count
    } else {
      return FavoriteWineList.shared.wines.count
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var curWine = Wine()
    if (self.listType == .fullList) {
      let key = AlphabeticalWineList.shared.sortedKeys[indexPath.section]
      curWine = AlphabeticalWineList.shared.wines[key]![indexPath.row]
    }
    else if (self.listType == .tasted) {
      curWine = TastedWineList.shared.wines[indexPath.row]
    } else {
      curWine = FavoriteWineList.shared.wines[indexPath.row]
    }
    let wineCell: WineCell = tableView.dequeueReusableCell(withIdentifier: WineCellId, for: indexPath as IndexPath) as! WineCell
    wineCell.layoutFor(wine: curWine)
    wineCell.delegate = self
    return wineCell
  }
  
  // MARK: UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return WineListViewCellHeight
  }
  
  override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    if (self.listType == .fullList) {
      return self.sectionTitles
    } else {
      return nil
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var curWine: Wine?
    if (self.listType == .fullList) {
      let key = AlphabeticalWineList.shared.sortedKeys[indexPath.section]
      curWine = AlphabeticalWineList.shared.wines[key]![indexPath.row]
    }
    else if (self.listType == .tasted) {
      curWine = TastedWineList.shared.wines[indexPath.row]
    } else {
      curWine = FavoriteWineList.shared.wines[indexPath.row]
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

extension WineListViewController: WineCellDelegate {
  
  func wineTastedWasToggled(_ wine: Wine, tasted: Bool, forCell: WineCell) {
    wine.toggleTasted()
    self.tableView.reloadData()
  }
  
  func wineFavoriteWasToggled(_ wine: Wine, favorited: Bool, forCell: WineCell) {
    wine.toggleFavorited()
    self.tableView.reloadData()
  }
  
}
