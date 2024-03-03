//
//  ContentView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/2/24.
//

import SwiftUI

struct ContentView: View {
    
    let size: CGFloat = 32
    let iconSize: CGFloat = 30
    
    var body: some View {
        VStack {
            Text("Primary Text")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)
            Rectangle()
                .fill(.backgroundSecondary)
                .frame(maxWidth: .infinity)
                .frame(height: 20)
            Text("Henke Winery")
                .font(.appTitle)
                .foregroundStyle(.textPrimary)
            Text("2018 Merlot")
                .font(.appText)
                .foregroundStyle(.textSecondary)
            HStack {
                Image.tabWine
                    .frame(width: iconSize, height: iconSize)
                Image.tabWineFilled
                    .frame(width: iconSize, height: iconSize)
                Image.tabSearch
                    .frame(width: iconSize, height: iconSize)
                Image.tabSearchFilled
                    .frame(width: iconSize, height: iconSize)
                Image.tabMyList
                    .frame(width: iconSize, height: iconSize)
                Image.tabMyListFilled
                    .frame(width: iconSize, height: iconSize)
                Image.tabTasted
                    .frame(width: iconSize, height: iconSize)
                Image.tabTastedFilled
                    .frame(width: iconSize, height: iconSize)
                Image.tabMap
                    .frame(width: iconSize, height: iconSize)
                Image.tabMapFilled
                    .frame(width: iconSize, height: iconSize)
            }
//            Text("Secondary Text")
//                .font(.system(size: 19))
//                .foregroundStyle(.textSecondary)
//            Text("Thin")
//                .font(.appThin(size: size))
//                .foregroundStyle(.textPrimary)
//            Text("Extra Light")
//                .font(.appExtraLight(size: size))
//                .foregroundStyle(.textPrimary)
//            Text("Light")
//                .font(.appLight(size: size))
//                .foregroundStyle(.textPrimary)
//            Text("Regular")
//                .font(.appRegular(size: size))
//                .foregroundStyle(.textPrimary)
//            Text("Medium")
//                .font(.appMedium(size: size))
//                .foregroundStyle(.textPrimary)
//            Text("SemiBold")
//                .font(.appSemiBold(size: size))
//                .foregroundStyle(.textPrimary)
//            Text("Bold")
//                .font(.appBold(size: size))
//                .foregroundStyle(.textPrimary)
//            Text("Extra Bold")
//                .font(.appExtraBold(size: size))
//                .foregroundStyle(.textPrimary)
//            Text("Black")
//                .font(.appBlack(size: size))
//                .foregroundStyle(.textPrimary)
            Spacer()
            ZStack {
                Rectangle()
                    .fill(.app)
                Text("ACTION")
                    .font(.actionButton)
                    .foregroundStyle(.white)
            }
            .frame(width: 300, height: 55)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .background(.backgroundSecondary)
    }
}

#Preview {
    ContentView()
}
