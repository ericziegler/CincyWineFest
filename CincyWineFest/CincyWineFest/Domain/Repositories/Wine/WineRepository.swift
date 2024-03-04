//
//  WineRepository.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/3/24.
//

import Foundation

class WineRepository: WineRepositoryProtocol {
    
    // MARK: - Properties
    
    private(set) var wines: Wines
    private(set) var cacheService: CacheServiceProtocol
    private let cacheKey = "WinesCacheKey"
    
    // MARK: - Init
    
    init(cacheService: CacheServiceProtocol = CacheService()) {
        self.wines = Wines()
        self.cacheService = cacheService
    }
    
    // MARK: - All Wines
    
    func loadWines() throws {
        guard let data = cacheService.loadData(for: cacheKey) else {
            throw RepoError.noDataFound
        }
        
        guard let loadedWines = try? JSONDecoder().decode(Wines.self, from: data) else {
            throw RepoError.failedToLoad
        }
        
        self.wines = loadedWines
    }
    
    private func saveWines() throws {
        guard let data = try? JSONEncoder().encode(wines) else {
            throw RepoError.failedtoEncode
        }
        
        cacheService.save(data: data, for: cacheKey)
    }
    
    // MARK: - Favorite Wines
    
    func addWineToFavorites(_ wine: Wine) throws {
        try toggleFavoriteWine(wine, isFavorite: true)
    }
    
    func removeWineFromFavorites(_ wine: Wine) throws {
        try toggleFavoriteWine(wine, isFavorite: false)
    }
    
    private func toggleFavoriteWine(_ wine: Wine, isFavorite: Bool) throws {
        guard let index = wines.firstIndex(where: { $0.id == wine.id }) else {
            throw RepoError.itemNotFound
        }
        
        wines[index].isFavorite = isFavorite
        
        try saveWines()
    }
    
    // MARK: - Tasted Wines
    
    func addWineToTasted(_ wine: Wine) throws {
        try toggleTastedWine(wine, hasTasted: true)
    }
    
    func removeWineFromTasted(_ wine: Wine) throws {
        try toggleTastedWine(wine, hasTasted: false)
    }
    
    private func toggleTastedWine(_ wine: Wine, hasTasted: Bool) throws {
        guard let index = wines.firstIndex(where: { $0.id == wine.id }) else {
            throw RepoError.itemNotFound
        }
        
        wines[index].hasTasted = hasTasted
        
        try saveWines()
    }
}
