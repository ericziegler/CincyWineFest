//
//  NavBarModifier.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/7/24.
//

import SwiftUI

struct NavBarModifier<Leading, Trailing>: ViewModifier where Leading: View, Trailing: View {
    var title: String
    var font: Font = Font.appTitle
    var offsetY: Double = 0
    var leadingView: Leading?
    var trailingView: Trailing?
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                // Leading
                if let leading = leadingView {
                    ToolbarItem(placement: .topBarLeading) {
                        leading
                    }
                }
                
                // Title
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(title)
                            .font(font)
                            .foregroundStyle(.white)
                            .offset(y: offsetY)
                    }
                }
                
                // Trailing
                if let trailing = trailingView {
                    ToolbarItem(placement: .topBarTrailing) {
                        trailing
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.app, for: .navigationBar)
    }
}

extension View {
    func appNavBar(title: String,
                   font: Font = .appTitle,
                   offsetY: Double = 0,
                   leading: some View = EmptyView(),
                   trailing: some View = EmptyView()) -> some View {
        self.modifier(NavBarModifier(title: title, font: font, offsetY: offsetY, leadingView: leading, trailingView: trailing))
    }
}
