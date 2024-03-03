//
//  Wine.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/3/24.
//

import Foundation

typealias Wines = [Wine]

struct Wine: Identifiable, Codable {
    let id: String
    let boothType: Booth
    let boothNumber: Int
    let winery: String
    let countries: [Country]
    let vintage: String
    let name: String
    let medal: Medal
    let isFavorite: Bool
    let hasTasted: Bool
    let rating: Int
    let notes: String
}
