//
//  CincyWineFestApp.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/2/24.
//

import SwiftUI

@main
struct CincyWineFestApp: App {
    
    // TODO: EZ - Remaining Items
    //      - Filters
    //      - Wine Details
    //      - Haptics
    //        - Star
    //        - My List/Favorite
    
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .onAppear(perform: {
                    appState.loadData()
                })
                .environmentObject(appState)
        }
    }
}
