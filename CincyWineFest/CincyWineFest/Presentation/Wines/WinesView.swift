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
        PageBackground {
            VStack {
                Button("PARSE WINES") {
                    viewModel.loadRawData()
                }
                .buttonStyle(.borderedProminent)
                
                Button("PRINT WINES") {
                    viewModel.saveData()
                }
                .buttonStyle(.borderedProminent)
                
                Button("LOAD BOOTHS") {
                    viewModel.loadBooths()
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    WinesView()
}
