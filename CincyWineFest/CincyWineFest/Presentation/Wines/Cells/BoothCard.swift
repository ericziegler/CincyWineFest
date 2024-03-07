//
//  BoothCard.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/7/24.
//

import SwiftUI

struct BoothCard: View {
    
    let booth: Booth
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                renderBoothHeader()
                ForEach(booth.wines, id: \.self) { wine in
                    WineCell(wine: wine,
                             showDivider: wine.id != booth.wines.last?.id) {
                        print("LISTED")
                    } onTasted: {
                        print("TASTED")
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.backgroundPrimary)
        .foregroundStyle(Color.textSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.textPrimary.opacity(0.15), lineWidth: 1)
        )
        .padding(.horizontal)
    }
    
    @ViewBuilder private func renderBoothHeader() -> some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                Text(booth.number)
                Text(booth.name)
                Spacer()
                ForEach(booth.countries, id: \.self) { country in
                    AnyView(country.flag)
                        .frame(height: 22)
                }
            }
            .font(.appBoldText)
            .padding(.horizontal)
            .padding(.vertical, 30)
            AppDivider()
        }
        .background(Color.backgroundSecondary)
    }

}

#Preview {
    PageBackground(overrideColor: .backgroundSecondary) {
        VStack {
            BoothCard(booth: Booth.mockBooths.last!)
        }
    }
}
