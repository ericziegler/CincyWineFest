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
    
    @State private var isShowingAlert = false
    
    var body: some View {
        NavigationStack {
            PageBackground {
                if let wine = appState.selectedWine {
                    renderDetails(for: wine)
                } else {
                    renderErrorView()
                }
            }
            .appNavBar(title: "Details", trailing: renderCloseButton())
            .alert(appState.alertInfo?.title ?? "",
                   isPresented: $isShowingAlert,
                   actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(appState.alertInfo?.message ?? "")
            })
        }
    }
    
    @ViewBuilder private func renderDetails(for wine: Wine) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                AnyView(wine.medal.icon)
                    .frame(height: 36)
                Text(wine.name)
                    .font(.appLargeTitle)
            }
            HStack {
                Text(appState.winery(for: wine)?.name.uppercased() ?? "")
                    .foregroundStyle(Color.textSecondary)
                    .font(.appBoldText)
                Spacer()
                FlagsView(countries: appState.winery(for: wine)?.countries ?? []) { country in
                    appState.showAlert(for: country)
                    isShowingAlert = true
                }
            }
            AppDivider()
            Spacer()
        }
        .frame(alignment: .leading)
        .foregroundStyle(Color.textPrimary)
        .padding()
    }
    
    @ViewBuilder private func renderErrorView() -> some View {
        NoContentView(title: "Ouch!",
                      message: "Something went majorly wrong. This is on me, not you...")
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
