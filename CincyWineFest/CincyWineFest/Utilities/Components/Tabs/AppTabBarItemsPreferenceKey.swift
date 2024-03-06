//
//  AppTabBarItemsPreferenceKey.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/6/24.
//

import SwiftUI

struct AppTabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [AppTabItem] = []
    
    static func reduce(value: inout [AppTabItem], nextValue: () -> [AppTabItem]) {
        value += nextValue()
    }
}

struct AppTabBarItemViewModifier: ViewModifier {
    
    let tab: AppTabItem
    @Binding var selection: AppTabItem
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1 : 0)
            .preference(key: AppTabBarItemsPreferenceKey.self, value: [tab])
    }
}

extension View {
    func appTabItem(tab: AppTabItem, selection: Binding<AppTabItem>) -> some View {
        modifier(AppTabBarItemViewModifier(tab: tab, selection: selection))
    }
}
