//
//  NSRange+WineFest.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 2/23/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import Foundation

extension NSRange {
  
  func toRange(_ string: String) -> Range<String.Index> {
    let start = string.index(string.startIndex, offsetBy: self.location)
    let end = string.index(start, offsetBy: self.length)
    
    return start..<end
  }
  
}
