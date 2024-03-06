//
//  AppTabBarView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/6/24.
//

import SwiftUI

struct AppTabBarView<Content:View>: View {
 
    @Binding var selection: AppTabItem
    @State private var tabs: [AppTabItem] = []
    let content: Content
    
    init(selection: Binding<AppTabItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                content
            }
            AppTabBar(tabs: tabs, selection: $selection)
        }
        .onPreferenceChange(AppTabBarItemsPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
    
}

#Preview {
    let tabs = [
        AppTabItem(index: 0, image: Image.tabWine, selectedImage: Image.tabWineFilled, title: "Wines"),
        AppTabItem(index: 1, image: Image.tabSearch, selectedImage: Image.tabSearchFilled, title: "Search"),
        AppTabItem(index: 2, image: Image.tabMyList, selectedImage: Image.tabMyListFilled, title: "My List"),
        AppTabItem(index: 3, image: Image.tabTasted, selectedImage: Image.tabTastedFilled, title: "Tasted"),
        AppTabItem(index: 4, image: Image.tabMap, selectedImage: Image.tabMapFilled, title: "Map")
    ]
    
    return AppTabBarView(selection: .constant(tabs.first!)) {
        Color.green
    }
}
