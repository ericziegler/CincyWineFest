//
//  BoothCard.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/7/24.
//

import SwiftUI

struct BoothCard: View {
    
    let booth: Booth
    
    var body: some View {
        Text(booth.name)
    }
}

#Preview {
    BoothCard(booth: Booth.mockBooths.last!)
}
