//
//  Wine.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/3/24.
//

import Foundation

typealias Wines = [Wine]

struct Wine: Identifiable, Codable {
    var id: String {
        String(describing: "\(year)-\(name)")
    }
    let year: String
    let name: String
    let medal: Medal
    var boothId: String?
    var isFavorite: Bool = false
    var hasTasted: Bool = false
    var rating: Int?
    var notes: String?
}
