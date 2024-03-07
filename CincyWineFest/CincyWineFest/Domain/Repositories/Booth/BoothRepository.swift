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
        let boothsData = try fileService.loadData(with: "wines")
        do {
            booths = try JSONDecoder().decode(Booths.self, from: boothsData)
            linkWinesAndBooths()
            print(booths)
        } catch {
            throw RepoError.failedToDecode
        }
    }
    
    private func linkWinesAndBooths() {
        for index in booths.indices {
            for wineIndex in booths[index].wines.indices {
                booths[index].wines[wineIndex].boothId = booths[index].id
            }
        }
    }
    
}
