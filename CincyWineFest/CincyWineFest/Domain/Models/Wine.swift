//
//  Wine.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/3/24.
//

import Foundation

typealias Wines = [Wine]

struct Wine: Identifiable, Hashable, Codable {
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

extension Wine {
    static var mockWines: Wines {
        [
            Wine(year: "2018",
                 name: "Castello Banfi Brunello di Montalcino DOCG",
                 medal: .silver,
                 boothId: "1",
                 isFavorite: false,
                 hasTasted: false,
                 rating: nil,
                 notes: nil),
            Wine(year: "2022",
                 name: "Domenica Pinot Grigio",
                 medal: .bronze,
                 boothId: "5",
                 isFavorite: false,
                 hasTasted: false,
                 rating: nil,
                 notes: nil),
            Wine(year: "2021",
                 name: "French Blue Bordeaux Rose",
                 medal: .none,
                 boothId: "5",
                 isFavorite: false,
                 hasTasted: false,
                 rating: nil,
                 notes: nil)
        ]
    }
}
