//
//  BoothRepository.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/6/24.
//

import Foundation

class BoothRepository: BoothRepositoryProtocol {
 
    // MARK: - Properties
    
    private(set) var booths: Booths
    private(set) var fileService: FileServiceProtocol
    private(set) var cacheService: CacheServiceProtocol
    private let cacheKey = "BoothsCacheKey"
    
    // MARK: - Init
    
    init(fileService: FileServiceProtocol = FileService(),
         cacheService: CacheServiceProtocol = CacheService()) {
        self.booths = Booths()
        self.fileService = fileService
        self.cacheService = cacheService
    }
    
    // MARK: - Loading
    
    func loadBooths() throws {
        defer {
            linkWinesAndBooths()
            print(booths)
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
    
    private func saveBoothsToCache() throws {
        guard let boothsData = try? JSONEncoder().encode(self.booths) else {
            throw RepoError.failedToEncode
        }
        
        self.cacheService.save(data: boothsData, for: cacheKey)
    }
    
    private func linkWinesAndBooths() {
        for index in booths.indices {
            for wineIndex in booths[index].wines.indices {
                booths[index].wines[wineIndex].boothId = booths[index].id
            }
        }
    }
    
}
