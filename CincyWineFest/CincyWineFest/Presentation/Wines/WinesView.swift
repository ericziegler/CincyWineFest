//
//  WinesView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/4/24.
//

import SwiftUI

struct WinesView: View {
    @EnvironmentObject private var appState: AppState
    
    private let indexBarData = ["1","10","20","30","40","50","60","70","80","90","A"]
    
    var body: some View {
        NavigationStack {
            PageBackground {
                VStack {
                    ScrollViewReader(content: { proxy in
                        ZStack {
                            renderBoothList()
                            renderIndexBar(scrollProxy: proxy)
                        }
                        .appNavBar(title: "Wine List")
                    })
                }
            }
            .alert(appState.alertInfo?.title ?? "",
                   isPresented: $appState.isShowingAlert,
                   actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(appState.alertInfo?.message ?? "")
            })
        }
    }
    
    @ViewBuilder private func renderBoothList() -> some View {
        List {
            ForEach(appState.boothSections, id: \.section) { section, boothsInSection in
                Section(header: EmptyView()) {
                    ForEach(boothsInSection, id: \.id) { booth in
                        BoothCard(booth: booth) { wine in
                            // tasted tapped
                            appState.toggleTasted(wine: wine)
                        } onListedTapped: { wine in
                            // listed tapped
                            appState.toggleListed(wine: wine)
                        } onCountryTapped: { country in
                            // country tapped
                            appState.showAlert(for: country)
                        }
                        .padding(.vertical, 8)
                        .listRowInsets(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 24))
                    }
                }
            }
        }
        .listStyle(.plain)
        .padding(.vertical, 16)
    }
    
    @ViewBuilder private func renderIndexBar(scrollProxy: ScrollViewProxy) -> some View {
        SwipeableIndexBar(indexTitles: indexBarData) { selectedTitle in
            scrollProxy.scrollTo(selectedTitle, anchor: .top)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    WinesView()
}
