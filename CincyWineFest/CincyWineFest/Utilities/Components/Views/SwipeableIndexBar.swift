//
//  SwipeableIndexBar.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/8/24.
//

import SwiftUI

struct SwipeableIndexBar: View {
    let indexTitles: [String]
    var onIndexSelected: (String) -> Void
    
    var body: some View {
        VStack {
            ForEach(indexTitles, id: \.self) { title in
                Text(title)
                    .font(.indexBar)
                    .foregroundStyle(Color.app)
                    .padding(1)
            }
        }
        .background(GeometryReader { geo in
            Color.clear
                .contentShape(Rectangle()) // Make sure the drag gesture covers the whole VStack area
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let indexHeight = geo.size.height / CGFloat(indexTitles.count)
                            let indexPosition = Int(value.location.y / indexHeight)
                            if indexPosition >= 0 && indexPosition < indexTitles.count {
                                let selectedTitle = indexTitles[indexPosition]
                                onIndexSelected(selectedTitle)
                            }
                        }
                )
        })
    }
}

#Preview {
    SwipeableIndexBar(indexTitles: ["A", "B", "C", "D"]) { index in
        
    }
}
