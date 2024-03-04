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
    
    // MARK: - Favorite Wines
    
    func loadFavorites() throws {
        
    }
    
    func addWineToFavorites(_ wine: Wine) throws {
        
    }
    
    func removeWineFromFavorites(_ wine: Wine) throws {
        
    }
    
    // MARK: - Tasted Wines
    
    func addWineToTasted(_ wine: Wine) throws {
        
    }
    
    func removeWineFromTasted(_ wine: Wine) throws {
        
    }
}
