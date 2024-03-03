//
//  ContentView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/2/24.
//

import SwiftUI

struct ContentView: View {
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
            Text("Secondary Text")
                .font(.system(size: 19))
                .foregroundStyle(.textSecondary)
            Spacer()
            ZStack {
                Rectangle()
                    .fill(.app)
                Text("ACTION")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            .frame(width: 300, height: 55)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .backgroundStyle(.backgroundPrimary)
    }
}

#Preview {
    ContentView()
}
