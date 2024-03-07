//
//  WinesView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/4/24.
//

import SwiftUI

struct WinesView: View {
    
    @StateObject private var viewModel = WinesViewModel()
    
    var body: some View {
        NavigationStack {
            PageBackground {
                List {
                    ForEach(viewModel.booths, id: \.id) { booth in
                        BoothCard(booth: booth)
                    }
                }
                .listStyle(.plain)
                .appNavBar(title: "Wine List")
                .background(Color.backgroundSecondary)
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
}

#Preview {
    WinesView()
}
