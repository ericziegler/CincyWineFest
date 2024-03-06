//
//  SearchView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/4/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        PageBackground {
            Text("Search")
        }
    }
}

#Preview {
    SearchView()
}
