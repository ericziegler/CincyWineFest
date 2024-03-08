//
//  MainTabView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/4/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var appState: AppState
    
    @State private var selectedTab = AppTabItem(index: 0, image: .tabWine, selectedImage: .tabWineFilled, title: "Wines")
    
    var body: some View {
        AppTabBarView(selection: $selectedTab) {
            WinesView()
                .appTabItem(tab: AppTabItem(index: 0,
                                            image: .tabWine,
                                            selectedImage: .tabWineFilled,
                                            title: "Wines"),
                            selection: $selectedTab)
                .environmentObject(appState)
            MyListView()
                .appTabItem(tab: AppTabItem(index: 2,
                                            image: .tabMyList,
                                            selectedImage: .tabMyListFilled,
                                            title: "My List"),
                            selection: $selectedTab)
                .environmentObject(appState)
            TastedView()
                .appTabItem(tab: AppTabItem(index: 3,
                                            image: .tabTasted,
                                            selectedImage: .tabTastedFilled,
                                            title: "Tasted"),
                            selection: $selectedTab)
                .environmentObject(appState)
            MapView()
                .appTabItem(tab: AppTabItem(index: 4,
                                            image: .tabMap,
                                            selectedImage: .tabMapFilled,
                                            title: "Map"),
                            selection: $selectedTab)
        }
    }
}

#Preview {
    MainTabView()
}
