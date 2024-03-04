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
    let winery: String
    let name: String
    let boothType: Booth
    let boothNumber: Int
    let countries: [Country]
    let vintage: String
    let medal: Medal
    let isFavorite: Bool
    let hasTasted: Bool
    let rating: Int
    let notes: String
    
    internal init(winery: String,
                  name: String,
                  boothType: Booth,
                  boothNumber: Int,
                  countries: [Country],
                  vintage: String,
                  medal: Medal,
                  isFavorite: Bool,
                  hasTasted: Bool,
                  rating: Int,
                  notes: String) {
        self.id = String(describing: "\(winery)-\(name)")
        self.boothType = boothType
        self.boothNumber = boothNumber
        self.winery = winery
        self.countries = countries
        self.vintage = vintage
        self.name = name
        self.medal = medal
        self.isFavorite = isFavorite
        self.hasTasted = hasTasted
        self.rating = rating
        self.notes = notes
    }
}
