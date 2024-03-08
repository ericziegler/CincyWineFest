//
//  BoothCard.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/7/24.
//

import SwiftUI

struct BoothCard: View {
    
    let booth: Booth
    
    var onTastedTapped: ((_ wine: Wine) -> Void)?
    var onListedTapped: ((_ wine: Wine) -> Void)?
    var onCountryTapped: ((_ country: Country) -> Void)?
    
    private var headerBackgroundColor: Color {
        switch booth.type {
        case .exhibit:
            return Color.exhibit
        case .food:
            return Color.food
        case .sponsor:
            return Color.sponsor
        case .waterNonAlcoholic:
            return Color.waterNonAlcoholic
        default:
            return Color.backgroundTertiary
        }
    }
    
    private var headerTextColor: Color {
        switch booth.type {
        case .exhibit, .sponsor, .waterNonAlcoholic:
            return Color.boothText
        case .food:
            return Color.white
        default:
            return Color.textSecondary
        }
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                renderBoothHeader()
                ForEach(booth.wines, id: \.id) { wine in
                    WineCell(wine: wine,
                             showDivider: wine.id != booth.wines.last?.id) {
                        onListedTapped?(wine)
                    } onTasted: {
                        onTastedTapped?(wine)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.backgroundSecondary)
        .foregroundStyle(headerTextColor)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.appSeparator, lineWidth: 1)
        )
//        .padding(.horizontal)
    }
    
    @ViewBuilder private func renderBoothHeader() -> some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                Text("\(booth.number) - \(booth.name.uppercased())")
                    .frame(alignment: .leading)

                Spacer()
                
                HStack {
                    ForEach(booth.countries, id: \.self) { country in
                        AnyView(country.flag)
                            .frame(height: 22)
                            .onTapGesture {
                                onCountryTapped?(country)
                            }
                    }
                }
                .padding(.leading, 0)
            }
            .font(.appBoldText)
            .padding(.horizontal)
            .padding(.vertical, 30)
            AppDivider()
        }
        .background(headerBackgroundColor)
    }

}

#Preview {
    PageBackground {
        VStack {
            BoothCard(booth: Booth.mockBooths.last!)
        }
    }
}