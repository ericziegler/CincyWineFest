//
//  PageBackground.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/4/24.
//

import SwiftUI

struct PageBackground<Content: View>: View {

    var overlay: (() -> AnyView?)?
    var overrideColor: Color?
    var color: Color {
        overrideColor ?? Color.backgroundPrimary
    }
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack {
            color
                .edgesIgnoringSafeArea(.all)
            HStack(content: content)
            if let overlay = overlay?() {
                overlay
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

#Preview {
    PageBackground {
        Text("Hello!")
    }
}
