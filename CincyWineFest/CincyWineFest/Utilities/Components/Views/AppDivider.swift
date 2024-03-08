//
//  AppDivider.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/7/24.
//

import SwiftUI

struct AppDivider: View {
 
    var body: some View {
        Rectangle()
            .fill(Color.appSeparator)
            .frame(maxWidth: .infinity)
            .frame(height: 1)
    }
}

#Preview {
    AppDivider()
}
