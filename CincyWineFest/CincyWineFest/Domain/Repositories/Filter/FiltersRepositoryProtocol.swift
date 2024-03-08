//
//  FiltersRepositoryProtocol.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/8/24.
//

import Foundation

protocol FiltersRepositoryProtocol {
    var filters: Filters { get }
    func loadFilters() throws
    func updateFilters(_ filters: Filters) throws
}
