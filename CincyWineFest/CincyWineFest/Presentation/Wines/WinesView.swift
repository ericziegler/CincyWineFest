//
//  WinesView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/4/24.
//

import SwiftUI

struct WinesView: View {
    @EnvironmentObject private var appState: AppState
    
    @State private var isShowingWine: Bool = false
    @State private var isShowingFilters: Bool = false
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
                        .appNavBar(title: "Wine List", trailing: renderFilterButton())
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
            .sheet(isPresented: $isShowingWine, content: {
                WineDetailsView()
                    .environmentObject(appState)
            })
            .sheet(isPresented: $isShowingFilters, onDismiss: {
                appState.saveFilters()
                appState.loadData()
            }, content: {
                FiltersView(filters: $appState.filters)
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
                        } onWineSelected: { wine in
                           // wine tapped
                           appState.selectedWine = wine
                           isShowingWine = true
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
    }
    
    @ViewBuilder private func renderIndexBar(scrollProxy: ScrollViewProxy) -> some View {
        SwipeableIndexBar(indexTitles: indexBarData) { selectedTitle in
            scrollProxy.scrollTo(selectedTitle, anchor: .top)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    @ViewBuilder private func renderFilterButton() -> some View {
        HStack {
            Image.filterDials
                .fontWeight(.bold)
                .foregroundStyle(appState.filters.hasActiveFilter ? .green : .white)
                .frame(height: 28)
        }
        .frame(width: 35, height: 35)
        .onTapGesture {
            isShowingFilters = true
        }
    }
}

#Preview {
    WinesView()
        .environmentObject(AppState())
}
