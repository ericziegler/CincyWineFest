//
//  WineCell.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/7/24.
//

import SwiftUI

struct WineCell: View {

    let wine: Wine
    var winery: Booth? = nil
    var showDivider: Bool = true
    var onListed: (() -> Void)? = nil
    var onTasted: (() -> Void)? = nil
    var onSelected: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                if let winery = self.winery {
                    Text(winery.name)
                        .font(.appSubtitle)
                        .foregroundStyle(Color.textSecondary)
                }
                HStack(alignment: .top) {
                    Text(wine.name)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    AnyView(wine.medal.icon)
                        .frame(height: 35)
                    renderActionButton(isTastedButton: false)
                    renderActionButton(isTastedButton: true)
                }
            }
            .padding(20)
            
            if showDivider {
                AppDivider()
            }
        }
        .font(.appText)
        .foregroundStyle(Color.textPrimary)
        .onTapGesture {
            onSelected?()
        }
    }
    
    @ViewBuilder private func renderActionButton(isTastedButton: Bool) -> some View {
        Button(action: {
            if isTastedButton {
                onTasted?()
            } else {
                onListed?()
            }
            FeedbackManager.playHaptic()
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
                        .foregroundStyle(wine.isListed ? Color.red : Color.textTertiary)
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
