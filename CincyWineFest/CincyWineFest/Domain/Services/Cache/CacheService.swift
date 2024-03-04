//
//  CacheService.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/3/24.
//

import Foundation

class CacheService: CacheServiceProtocol {
    
    private let userDefaults = UserDefaults()
    
    func loadData(for key: String) -> Data? {
        return userDefaults.data(forKey: key)
    }
    
    func save(data: Data, for key: String) {
        userDefaults.set(data, forKey: key)
    }
    
    func removeData(for key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
