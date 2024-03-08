//
//  Font+Extensions.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/2/24.
//

import SwiftUI

extension Font {
    
    // MARK: - Styled Guide Fonts
    
    static var appTitle: Font {
        appMedium(size: 21)
    }
    
    static var appLargeTitle: Font {
        appLight(size: 28)
    }
    
    static var appText: Font {
        appRegular(size: 19)
    }
    
    static var appBoldText: Font {
        appBold(size: 19)
    }
    
    static var appSubtitle: Font {
        appRegular(size: 17)
    }
    
    static var actionButton: Font {
        appBold(size: 22)
    }
    
    static var tab: Font {
        appMedium(size: 16)
    }
    
    static var indexBar: Font {
        appBlack(size: 12)
    }
    
    static var emptyTitle: Font {
        appBold(size: 36)
    }
    
    static var emptyMessage: Font {
        appMedium(size: 24)
    }
    
    // MARK: - Internal Fonts
    
    private static func appThin(size: CGFloat) -> Font {
        Font.custom("Inter-Thin", size: size)
    }
    
    private static func appExtraLight(size: CGFloat) -> Font {
        Font.custom("Inter-ExtraLight", size: size)
    }
    
    private static func appLight(size: CGFloat) -> Font {
        Font.custom("Inter-Light", size: size)
    }
    
    private static func appRegular(size: CGFloat) -> Font {
        Font.custom("Inter-Regular", size: size)
    }
    
    private static func appMedium(size: CGFloat) -> Font {
        Font.custom("Inter-Medium", size: size)
    }
    
    private static func appSemiBold(size: CGFloat) -> Font {
        Font.custom("Inter-SemiBold", size: size)
    }
    
    private static func appBold(size: CGFloat) -> Font {
        Font.custom("Inter-Bold", size: size)
    }
    
    private static func appExtraBold(size: CGFloat) -> Font {
        Font.custom("Inter-ExtraBold", size: size)
    }
    
    private static func appBlack(size: CGFloat) -> Font {
        Font.custom("Inter-Black", size: size)
    }
    
}
