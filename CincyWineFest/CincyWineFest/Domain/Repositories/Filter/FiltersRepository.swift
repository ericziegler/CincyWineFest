//
//  FiltersRepository.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/8/24.
//

import Foundation

class FiltersRepository: FiltersRepositoryProtocol {
 
    var filters: Filters = Filters()
    
    private let userDefaults = UserDefaults.standard
    private let cacheKey = "FiltersCacheKey"
    
    // MARK: - Init
    
    func loadFilters() throws {
        guard let filtersData = userDefaults.object(forKey: cacheKey) as? Data else {
            throw RepoError.noDataFound
        }
        
        guard let cachedFilters = try? JSONDecoder().decode(Filters.self, from: filtersData) else {
            throw RepoError.failedToLoad
        }
        
        self.filters = cachedFilters
    }
    
    func updateFilters(_ filters: Filters) throws {
        self.filters = filters
        do {
            let filtersData = try JSONEncoder().encode(filters)
            userDefaults.setValue(filtersData, forKey: cacheKey)
        } catch {
            throw RepoError.failedToEncode
        }
    }
    
}
