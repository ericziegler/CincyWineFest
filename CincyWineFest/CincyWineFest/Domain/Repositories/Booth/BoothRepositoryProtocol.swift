//
//  BoothRepositoryProtocol.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/6/24.
//

import Foundation

protocol BoothRepositoryProtocol {
    var booths: Booths { get }
    func loadBooths() throws
}
