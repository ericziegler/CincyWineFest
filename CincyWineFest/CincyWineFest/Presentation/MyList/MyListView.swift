//
//  MyListView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/4/24.
//

import SwiftUI

struct MyListView: View {
    
    @StateObject private var viewModel = MyListViewModel()
    
    var body: some View {
        PageBackground {
            Text("My List")
        }
    }
}

#Preview {
    MyListView()
}
