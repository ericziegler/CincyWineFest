//
//  DIManager.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/4/24.
//

import Foundation
import Swinject

enum TargetType: String {
    case app = "AppCache"
    case unitTest = "TestCache"
    
    var isUnitTesting: Bool {
        switch self {
            case .app:
                return false
            case .unitTest:
                return true
        }
    }
}

struct DIManager {
    
    static var targetType: TargetType = .app
    
    // MARK: Repository Resolves
    
    static func resolveWineRepository() -> WineRepositoryProtocol {
        return self.shared.resolve(WineRepositoryProtocol.self)!
    }

    // MARK: Services Resolves
    
    static func resolveCacheService() -> CacheServiceProtocol {
        return self.shared.resolve(CacheServiceProtocol.self)!
    }
}

extension DIManager {
    private static let shared: Container = {
        let container = Container()
        
        // MARK: - Repositories
        
        container.register(WineRepositoryProtocol.self) { r in
            let cacheService = r.resolve(CacheServiceProtocol.self)!
            return WineRepository(cacheService: cacheService)
        }.inObjectScope(.container)
        
        // MARK: - Services
        
        container.register(CacheServiceProtocol.self) { r in
            return CacheService()
        }.inObjectScope(.container)

        return container
    }()
}
