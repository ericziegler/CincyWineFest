//
//  WineRepositoryProtocol.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/3/24.
//

import Foundation

protocol WineRepositoryProtocol {
    // Properties
    var wines: Wines { get }
    // All Wines
    func loadWines() throws
    // Favorite Wines
    func loadFavorites() throws
    func addWineToFavorites(_ wine: Wine) throws
    func removeWineFromFavorites(_ wine: Wine) throws
    // Tasted Wines
    func addWineToTasted(_ wine: Wine) throws
    func removeWineFromTasted(_ wine: Wine) throws
}
