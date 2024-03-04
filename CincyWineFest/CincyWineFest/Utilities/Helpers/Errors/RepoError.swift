//
//  RepoError.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/3/24.
//

import Foundation

enum RepoError: LocalizedError {
    case noDataFound
    case failedToLoad
    case failedtoEncode
    case failedToSave
    case itemNotFound
}
