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
            Text("Wines")
        }
    }
}

#Preview {
    WinesView()
}
