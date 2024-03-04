//
//  MapView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/4/24.
//

import SwiftUI

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        Text("Map")
    }
}

#Preview {
    MapView()
}
