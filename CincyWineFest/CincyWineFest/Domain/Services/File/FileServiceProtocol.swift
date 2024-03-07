//
//  FileServiceProtocol.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/7/24.
//

import Foundation

protocol FileServiceProtocol {
    func loadData(with fileName: String) throws -> Data
    func loadText(with fileName: String) throws -> String
}
