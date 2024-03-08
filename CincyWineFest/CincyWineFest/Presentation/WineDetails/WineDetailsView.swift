//
//  WineDetailsView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/8/24.
//

import SwiftUI

struct WineDetailsView: View {
    @Environment (\.dismiss) private var dismiss
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        NavigationStack {
            PageBackground {
                Text(appState.selectedWine?.name ?? "")
            }
            .appNavBar(title: "Details", trailing: renderCloseButton())
        }
    }
    
    @ViewBuilder private func renderCloseButton() -> some View {
        HStack {
            Image(systemName: "xmark")
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(height: 22)
        }
        .frame(width: 35, height: 35)
        .onTapGesture {
            dismiss()
        }
    }
}

#Preview {
    WineDetailsView()
        .environmentObject(AppState())
}
