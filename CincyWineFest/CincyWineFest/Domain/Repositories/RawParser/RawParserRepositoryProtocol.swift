//
//  RawParserRepositoryProtocol.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/7/24.
//

import Foundation

protocol RawParserRepositoryProtocol {
    var booths: Booths { get }
    func loadAndParseData() throws
    func printData() throws
}
