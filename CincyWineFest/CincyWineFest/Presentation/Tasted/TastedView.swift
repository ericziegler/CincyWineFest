//
//  TastedView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/4/24.
//

import SwiftUI

struct TastedView: View {
    
    @StateObject private var viewModel = TastedViewModel()
    
    var body: some View {
        Text("Tasted")
    }
}

#Preview {
    TastedView()
}
