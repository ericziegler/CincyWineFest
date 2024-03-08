//
//  BoothRepositoryProtocol.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/6/24.
//

import Foundation

protocol WineRepositoryProtocol {
    var booths: Booths { get }
    var allWines: Wines { get }
    var listedWines: Wines { get }
    var tastedWines: Wines { get }
    
    func loadData(filters: Filters) throws
    func toggleWineListed(isListed: Bool, for wine: Wine) throws
    func toggleWineTasted(hasTasted: Bool, for wine: Wine) throws
    func updateRating(rating: Int, for wine: Wine) throws
    func updateNotes(notes: String, for wine: Wine) throws
    func winery(for wine: Wine) -> Booth?
}
