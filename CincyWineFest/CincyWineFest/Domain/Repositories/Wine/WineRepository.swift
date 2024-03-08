//
//  WineRepository.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/6/24.
//

import Foundation

class WineRepository: WineRepositoryProtocol {
 
    // MARK: - Properties
    
    private(set) var booths: Booths
    var allWines: Wines {
        booths.flatMap { $0.wines }
    }
    var listedWines: Wines {
        return booths.flatMap { $0.wines }.filter { $0.isListed }
    }
    var tastedWines: Wines {
        return booths.flatMap { $0.wines }.filter { $0.hasTasted }
    }
    
    private(set) var fileService: FileServiceProtocol
    private(set) var cacheService: CacheServiceProtocol
    private let cacheKey = "WinesCacheKey"
    
    // MARK: - Init
    
    init(fileService: FileServiceProtocol = FileService(),
         cacheService: CacheServiceProtocol = CacheService()) {
        self.booths = Booths()
        self.fileService = fileService
        self.cacheService = cacheService
    }
    
    // MARK: - Loading
    
    func loadData(filters: Filters) throws {
        defer {
            applyFilters(filters: filters)
            sortAllWines()
            linkWinesAndBooths()
        }
        
        do {
            try loadBoothsFromCache()
        } catch {
            try loadDefaultBooths()
        }
    }
    
    private func loadBoothsFromCache() throws {
        guard let boothsData = cacheService.loadData(for: cacheKey) else {
            throw RepoError.noDataFound
        }
        
        guard let cachedBooths = try? JSONDecoder().decode(Booths.self, from: boothsData) else {
            throw RepoError.failedToDecode
        }
        
        self.booths = cachedBooths
    }
    
    private func loadDefaultBooths() throws {
        let boothsData = try fileService.loadData(with: "wines")
        guard let cachedBooths = try? JSONDecoder().decode(Booths.self, from: boothsData) else {
            throw RepoError.failedToDecode
        }
        self.booths = cachedBooths
        
        try? saveBoothsToCache()
    }
    
    private func applyFilters(filters: Filters) {
        
    }
    
    // MARK: - Saving
    
    private func saveBoothsToCache() throws {
        guard let boothsData = try? JSONEncoder().encode(self.booths) else {
            throw RepoError.failedToEncode
        }
        
        self.cacheService.save(data: boothsData, for: cacheKey)
    }
    
    // MARK: - Helpers
    
    private func sortAllWines() {
        for index in booths.indices {
            booths[index].wines.sort { $0.name < $1.name }
        }
    }
    
    private func linkWinesAndBooths() {
        for index in booths.indices {
            for wineIndex in booths[index].wines.indices {
                booths[index].wines[wineIndex].boothId = booths[index].id
            }
        }
    }
    
    // MARK: - Updating
    
    func toggleWineListed(isListed: Bool, for wine: Wine) throws {
        try updateWine(with: wine.id) { $0.isListed = isListed }
    }

    func toggleWineTasted(hasTasted: Bool, for wine: Wine) throws {
        try updateWine(with: wine.id) { $0.hasTasted = hasTasted }
    }

    func updateRating(rating: Int, for wine: Wine) throws {
        try updateWine(with: wine.id) { $0.rating = rating }
    }

    func updateNotes(notes: String, for wine: Wine) throws {
        try updateWine(with: wine.id) { $0.notes = notes }
    }
    
    private func updateWine(with wineId: String, updateAction: (inout Wine) -> Void) throws {
        outerLoop: for (boothIndex, booth) in booths.enumerated() {
            for (wineIndex, wine) in booth.wines.enumerated() {
                if wine.id == wineId {
                    var updatedWine = wine
                    updateAction(&updatedWine)
                    booths[boothIndex].wines[wineIndex] = updatedWine
                    break outerLoop
                }
            }
        }
        
        try saveBoothsToCache()
    }
    
    func winery(for wine: Wine) -> Booth? {
        guard let booth = booths.first(where: { $0.id == wine.boothId }) else {
            return nil
        }
        
        return booth
    }
    
}
