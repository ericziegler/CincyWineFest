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
  let sectionTitles = ["1", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "60", "65", "70", "75", "80", "85", "90", "95", "100", "105", "110", "115", "120", "125", "130"]
  
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
    self.tableView.sectionIndexColor = UIColor.navBar
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.estimatedRowHeight = WineListViewCellHeight
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if (self.listType == .fullList) {
      OrderedWineList.shared.orderWines()
    }
    self.tableView.reloadData()
  }
  
  private func setupNavBar() {
    if self.listType == .fullList {
      self.navigationItem.title = "Wine Festival".uppercased()
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
      return OrderedWineList.shared.wines.keys.count
    } else {
      return 1
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (self.listType == .fullList) {
      let key = OrderedWineList.shared.sortedKeys[section]
      return OrderedWineList.shared.wines[key]!.count
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
      let key = OrderedWineList.shared.sortedKeys[indexPath.section]
      curWine = OrderedWineList.shared.wines[key]![indexPath.row]
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
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var curWine: Wine?
    if (self.listType == .fullList) {
      let key = OrderedWineList.shared.sortedKeys[indexPath.section]
      curWine = OrderedWineList.shared.wines[key]![indexPath.row]
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
  
  override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    if (self.listType == .fullList) {
      return self.sectionTitles
    } else {
      return nil
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
