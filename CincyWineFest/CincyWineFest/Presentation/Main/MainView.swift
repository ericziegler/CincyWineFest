//
//  MainView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/7/24.
//

import SwiftUI

struct MainView: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var isSplashViewActive = true
    
    var body: some View {
        ZStack {
            if isSplashViewActive {
                SplashScreenView()
                    .transition(.opacity)
            } else {
                MainTabView()
            }
        }
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .active:
                Task {
                    try? await Task.sleep(nanoseconds: 2_000_000_000)
                    withAnimation(.easeOut(duration: 0.5)) {
                        isSplashViewActive = false
                    }
                }
            default:
                break
            }
        }
    }
}

#Preview {
    MainView()
}
