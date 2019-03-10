//
//  PhotoViewController.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import UIKit

// MARK: Constants

let PhotoViewId = "PhotoViewId"

class PhotoViewController: BaseViewController {
  
  // MARK: Properties
  
  @IBOutlet var imageView: GTZoomableImageView!
  var wine: Wine!
  
  // MARK: Init
  
  class func createControllerForWine(wine: Wine) -> PhotoViewController {
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController: PhotoViewController = storyboard.instantiateViewController(withIdentifier: PhotoViewId) as! PhotoViewController
    viewController.wine = wine
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.imageView.image = wine.photo
    self.setupNavBar()
  }
  
  private func setupNavBar() {
    if let closeImage = UIImage(named: "Close")?.maskedImageWithColor(UIColor.lightAccent) {
      let closeButton = UIButton(type: .custom)
      closeButton.addTarget(self, action: #selector(closeTapped(_:)), for: .touchUpInside)
      closeButton.setImage(closeImage, for: .normal)
      closeButton.frame = CGRect(x: 0, y: 0, width: closeImage.size.width, height: closeImage.size.height)
      let closeItem = UIBarButtonItem(customView: closeButton)
      
      self.navigationItem.rightBarButtonItems = [closeItem]
    }
  }
  
  @IBAction func closeTapped(_ sender: AnyObject) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
