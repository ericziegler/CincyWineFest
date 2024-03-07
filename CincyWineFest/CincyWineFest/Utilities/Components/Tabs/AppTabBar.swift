//
//  AppTabBar.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/6/24.
//

import SwiftUI

struct AppTabBar: View {
    
    let tabs: [AppTabItem]
    @Binding var selection: AppTabItem
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                renderTab(tab)
                    .onTapGesture {
                        selection = tab
                    }
            }
        }
        .padding(6)
        .background(Color.app.ignoresSafeArea(edges: .bottom))
    }
    
    @ViewBuilder private func renderTab(_ tab: AppTabItem) -> some View {
        VStack {
            renderIcon(for: tab)
                .frame(height: 22)
            Text(tab.title)
                .font(.tab)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .fontWeight(selection == tab ? .semibold : .regular)
        .foregroundStyle(selection == tab ? .white : .appSecondary)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder private func renderIcon(for tab: AppTabItem) -> some View {
        if selection == tab {
            tab.selectedImage
                .resizeAndFit()
        } else {
            tab.image
                .resizeAndFit()
        }
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
    
    return VStack {
        Spacer()
        AppTabBar(tabs: tabs, selection: .constant(tabs.first!))
    }
}
