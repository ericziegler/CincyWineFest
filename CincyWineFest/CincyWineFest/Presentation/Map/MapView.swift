//
//  MapView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/4/24.
//

import SwiftUI

struct MapView: View {    
    var body: some View {
        ZoomableImageView(name: "Map")
            .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    MapView()
}
