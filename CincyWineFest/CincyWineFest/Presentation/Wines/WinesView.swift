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
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.booths, id: \.id) { booth in
                            BoothCard(booth: booth)
                        } 
                    }
                    .padding(.vertical, 16)
                }
                .appNavBar(title: "Wine List")
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
