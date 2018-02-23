//
//  UIImage+WineFest.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import UIKit

extension UIImage {
  
  func maskedImageWithColor(_ color: UIColor) -> UIImage? {
    var result: UIImage?
    
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
    
    if let context: CGContext = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
      let rect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
      
      // flip coordinate system or else CGContextClipToMask will appear upside down
      context.translateBy(x: 0, y: rect.size.height);
      context.scaleBy(x: 1.0, y: -1.0);
      
      // mask and fill
      context.setFillColor(color.cgColor)
      context.clip(to: rect, mask: cgImage);
      context.fill(rect)
      
    }
    
    result = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return result
  }
  
}
