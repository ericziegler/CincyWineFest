//
//  WineCell.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/7/24.
//

import SwiftUI

struct WineCell: View {

    let wine: Wine
    var winery: String? = nil
    var showDivider: Bool = true
    var onListed: (() -> Void)? = nil
    var onTasted: (() -> Void)? = nil
    
    @State private var hasTasted: Bool
    @State private var isListed: Bool
    
    init(wine: Wine,
         winery: String? = nil,
         showDivider: Bool,
         onListed: ( () -> Void)? = nil,
         onTasted: ( () -> Void)? = nil) {
        self.wine = wine
        self.winery = winery
        self.showDivider = showDivider
        self.onListed = onListed
        self.onTasted = onTasted
        self.isListed = wine.isListed
        self.hasTasted = wine.hasTasted
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    AnyView(wine.medal.icon)
                        .frame(height: 24)
                    Text(wine.name)
                    Spacer()
                    renderActionButton(isTastedButton: false)
                    renderActionButton(isTastedButton: true)
                }
                if let winery = self.winery {
                   Text(winery)
                        .font(.appSubtitle)
                        .foregroundStyle(Color.textSecondary)
                }
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
                hasTasted.toggle()
                onTasted?()
            } else {
                isListed.toggle()
                onListed?()
            }
        }, label: {
            HStack {
                Spacer()
                if isTastedButton {
                    Image.tabTasted
                        .resizeAndFit()
                        .frame(height: 24)
                        .foregroundStyle(hasTasted ? Color.green : Color.textTertiary)
                } else {
                    Image.tabMyList
                        .resizeAndFit()
                        .frame(height: 24)
                        .foregroundStyle(isListed ? Color.red : Color.textTertiary)
                }
            }
            .frame(width: 35, height: 35)
        })
        .buttonStyle(.borderless) // Needs to be borderless so that it doesn't interfere with other cells
    }
}

#Preview {
    WineCell(wine: Wine.mockWines.first!, showDivider: false)
}
