//
//  CacheServiceProtocol.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/3/24.
//

import Foundation

protocol CacheServiceProtocol {
    func loadData(for key: String) -> Data?
    func save(data: Data, for key: String)
    func removeData(for key: String)
}