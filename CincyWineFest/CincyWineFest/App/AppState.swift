//
//  AppState.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/8/24.
//

import Foundation

@MainActor
class AppState: ObservableObject {
    @Published var booths = Booths()
    @Published var tastedWines = Wines()
    @Published var listedWines = Wines()
    @Published var isShowingAlert = false
    var alertInfo: AlertInfo?
    
    var boothSections: [(section: String, booths: [Booth])] {
        // Group booths by a full numeric prefix or the first letter if not numeric
        let grouped = Dictionary(grouping: booths) { (booth: Booth) -> String in
            // Extract a numeric prefix or use the first character for non-numeric identifiers
            let prefix = booth.number.prefix { $0.isNumber }
            return prefix.isEmpty ? String(booth.number.first ?? " ") : String(prefix)
        }

        // Convert dictionary to sorted array
        let sortedSections = grouped.sorted { lhs, rhs in
            // Attempt to sort numerically first, then alphabetically for ties or non-numeric
            switch (Int(lhs.key), Int(rhs.key)) {
            case let (.some(lhsInt), .some(rhsInt)):
                return lhsInt < rhsInt
            case (.some, .none):
                return true
            case (.none, .some):
                return false
            default:
                return lhs.key < rhs.key
            }
        }

        // Map the sorted sections to the expected return type
        let mappedSections = sortedSections.map { (section: $0.key, booths: $0.value) }
        return mappedSections
    }
    
    private let wineRepo: WineRepositoryProtocol
    
    init(wineRepo: WineRepositoryProtocol = WineRepository()) {
        self.wineRepo = wineRepo
    }
    
    func loadData() {
        do {
            try wineRepo.loadData()
            self.booths = wineRepo.booths.sorted(by: {
                switch (Int($0.id), Int($1.id)) {
                case let (.some(firstId), .some(secondId)):
                    // Both IDs are numbers, compare numerically
                    return firstId < secondId
                case (.some(_), .none):
                    // The first ID is a number, and the second is not, the first should come first
                    return true
                case (.none, .some(_)):
                    // The second ID is a number, and the first is not, the second should come first
                    return false
                case (.none, .none):
                    // Both IDs are not numbers, compare alphabetically but place them at the bottom
                    return $0.id < $1.id
                }
            })
            
            loadListed()
            loadTasted()
        } catch {
            alertInfo = AlertInfo(title: "Uh oh!", message: "We were unable to load the wine list.")
            isShowingAlert = true
        }
    }
    
    private func loadListed() {
        do {
            try wineRepo.loadData()
            listedWines = wineRepo.listedWines.sorted(by: { $0.name < $1.name })
        } catch {
            alertInfo = AlertInfo(title: "Uh oh!", message: "We were unable to load your list.")
            isShowingAlert = true
        }
    }
    
    private func loadTasted() {
        do {
            try wineRepo.loadData()
            tastedWines = wineRepo.tastedWines.sorted(by: { $0.name < $1.name })
        } catch {
            alertInfo = AlertInfo(title: "Uh oh!", message: "We were unable to load your list.")
            isShowingAlert = true
        }
    }
    
    func showAlert(for country: Country) {
        alertInfo = AlertInfo(title: country.formattedName, message: nil)
        self.isShowingAlert = true
    }
    
    func toggleListed(wine: Wine) {
        try? wineRepo.toggleWineListed(isListed: !wine.isListed, for: wine)
        loadData()
    }
    
    func toggleTasted(wine: Wine) {
        try? wineRepo.toggleWineTasted(hasTasted: !wine.hasTasted, for: wine)
        loadData()
    }
    
    func winery(for wine: Wine) -> Booth? {
        return wineRepo.winery(for: wine)
    }
}
