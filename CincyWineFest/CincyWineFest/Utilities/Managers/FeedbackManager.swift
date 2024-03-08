//
//  FeedbackManager.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/8/24.
//

import SwiftUI
import AVFoundation

class FeedbackManager: ObservableObject {
    
    // MARK: - Properties
    
    private static let mediumHaptic = UIImpactFeedbackGenerator(style: .medium)
    
    // MARK: - Haptics
    
    static func playHaptic() {
        mediumHaptic.impactOccurred()
    }
}
