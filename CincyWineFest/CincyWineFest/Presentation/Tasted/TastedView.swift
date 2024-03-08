//
//  TastedView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/4/24.
//

import SwiftUI

struct TastedView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        NavigationStack {
            PageBackground {
                List {
                    ForEach(appState.tastedWines, id: \.id) { wine in
                        WineCell(wine: wine,
                                 winery: appState.winery(for: wine),
                                 showDivider: false) {
                            appState.toggleListed(wine: wine)
                        } onTasted: {
                            appState.toggleTasted(wine: wine)
                        }
                        .listRowInsets(EdgeInsets())
                    }
                }
                .listStyle(.plain)
            }
            .appNavBar(title: "Tasted")
            .alert(appState.alertInfo?.title ?? "",
                   isPresented: $appState.isShowingAlert,
                   actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(appState.alertInfo?.message ?? "")
            })
        }
    }
}

#Preview {
    TastedView()
}
