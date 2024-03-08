//
//  WinesView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/4/24.
//

import SwiftUI

struct WinesView: View {
    
    @StateObject private var viewModel = WinesViewModel()
    
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
            .task {
                viewModel.loadBooths()
            }
            .alert(viewModel.alertInfo?.title ?? "",
                   isPresented: $viewModel.isShowingAlert,
                   actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(viewModel.alertInfo?.message ?? "")
            })
        }
    }
    
    @ViewBuilder private func renderBoothList() -> some View {
        List {
            ForEach(viewModel.boothSections, id: \.section) { section, boothsInSection in
                Section(header: EmptyView()) {
                    ForEach(boothsInSection, id: \.id) { booth in
                        BoothCard(booth: booth)
                            .padding(.vertical, 8)
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
