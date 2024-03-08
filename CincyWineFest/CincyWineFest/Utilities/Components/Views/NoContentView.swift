//
//  NoContentView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/8/24.
//

import SwiftUI

struct NoContentView: View {
    
    var title: String = "Hold Your Glass Steady!"
    var message: String = "No spills here, just space for your favorite pours."
    
    var body: some View {
        PageBackground {
            VStack(spacing: 16) {
                Image.brokenGlass
                    .frame(height: 150)
                Text(title)
                    .font(.emptyTitle)
                Text(message)
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
