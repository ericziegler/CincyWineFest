//
//  NoContentView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/8/24.
//

import SwiftUI

struct NoContentView: View {
    var body: some View {
        PageBackground {
            VStack(spacing: 16) {
                Image.brokenGlass
                    .frame(height: 150)
                Text("Hold Your Glass Steady!")
                    .font(.emptyTitle)
                Text("No spills here, just space for your favorite pours.")
                    .font(.emptyMessage)
            }
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.textSecondary)
            .padding(40)
        }
        .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    NoContentView()
}
