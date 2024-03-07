//
//  SplashScreenView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/7/24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Image("Splash")
                .resizeAndFill()
                .ignoresSafeArea(edges: .all)
            Image("Logo")
                .resizeAndFit()
                .padding(EdgeInsets(top: -75, leading: 50, bottom: 75, trailing: 50))
        }
    }
}

#Preview {
    SplashScreenView()
}
