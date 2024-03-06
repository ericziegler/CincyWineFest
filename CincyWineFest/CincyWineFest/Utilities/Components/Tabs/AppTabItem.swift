//
//  AppTabItem.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/6/24.
//

import SwiftUI

struct AppTabItem: Hashable {
    let index: Int
    let image: Image
    let selectedImage: Image
    let title: String
    
    var hashValue: Int {
        return title.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(index)
      hasher.combine(title)
    }

    static func == (lhs: AppTabItem, rhs: AppTabItem) -> Bool {
        return lhs.index == rhs.index && lhs.index == rhs.index
    }
}
