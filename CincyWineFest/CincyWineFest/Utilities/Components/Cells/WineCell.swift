//
//  WineCell.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/7/24.
//

import SwiftUI

struct WineCell: View {

    let wine: Wine
    var showDivider: Bool = true
    var onListed: (() -> Void)? = nil
    var onTasted: (() -> Void)? = nil
    
    init(wine: Wine,
         showDivider: Bool = true,
         onListed: (() -> Void)? = nil,
         onTasted: (() -> Void)? = nil) {
        self.wine = wine
        self.showDivider = showDivider
        self.onListed = onListed
        self.onTasted = onTasted
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                AnyView(wine.medal.icon)
                    .frame(height: 24)
                Text(wine.name)
                Spacer()
                renderActionButton(isTastedButton: false)
                renderActionButton(isTastedButton: true)
            }
            .padding(20)
            
            if showDivider {
                AppDivider()
            }
        }
        .font(.appText)
        .foregroundStyle(Color.textPrimary)
    }
    
    @ViewBuilder private func renderActionButton(isTastedButton: Bool) -> some View {
        Button(action: {
            if isTastedButton {
                onTasted?()
            } else {
                onListed?()
            }
        }, label: {
            HStack {
                Spacer()
                if isTastedButton {
                    Image.tabTasted
                        .resizeAndFit()
                        .frame(height: 24)
                        .foregroundStyle(wine.hasTasted ? Color.green : Color.textTertiary)
                } else {
                    Image.tabMyList
                        .resizeAndFit()
                        .frame(height: 24)
                        .foregroundStyle(wine.isFavorite ? Color.red : Color.textTertiary)
                }
            }
            .frame(width: 35, height: 35)
        })
    }
}

#Preview {
    WineCell(wine: Wine.mockWines.first!, showDivider: false)
}
