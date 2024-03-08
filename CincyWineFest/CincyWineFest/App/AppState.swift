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
    @Published var filters = Filters()
    @Published var isShowingAlert = false
    var selectedWine: Wine?
    var alertInfo: AlertInfo?
    
    var boothSections: [(section: String, booths: [Booth])] {
        // Group booths by a full numeric prefix or the first letter if not numeric
        let grouped = Dictionary(grouping: filteredBooths()) { (booth: Booth) -> String in
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
    
    func filteredBooths() -> [Booth] {
        guard filters.showGoldMedals || filters.showSilverMedals || filters.showBronzeMedals else {
            // If no filters are active, return all booths as is
            return booths
        }

        // Filter booths to only include those with wines matching the active medal filters
        return booths.compactMap { booth -> Booth? in
            var filteredBooth = booth
            filteredBooth.wines = booth.wines.filter { wine in
                (filters.showGoldMedals && wine.medal == .gold) ||
                (filters.showSilverMedals && wine.medal == .silver) ||
                (filters.showBronzeMedals && wine.medal == .bronze)
            }
            
            // Only include booths that have at least one matching wine after filtering
            return filteredBooth.wines.isEmpty ? nil : filteredBooth
        }
    }
    
    private let wineRepo: WineRepositoryProtocol
    private let filtersRepo: FiltersRepositoryProtocol
    
    init(wineRepo: WineRepositoryProtocol = WineRepository(),
         filtersRepo: FiltersRepositoryProtocol = FiltersRepository()) {
        self.wineRepo = wineRepo
        self.filtersRepo = filtersRepo
    }
    
    func loadData() {
        do {
            try wineRepo.loadData(filters: filters)
            loadFilters()
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
            try wineRepo.loadData(filters: Filters()) // do not filter listed wines
            listedWines = wineRepo.listedWines.sorted(by: { $0.name < $1.name })
        } catch {
            alertInfo = AlertInfo(title: "Uh oh!", message: "We were unable to load your list.")
            isShowingAlert = true
        }
    }
    
    private func loadTasted() {
        do {
            try wineRepo.loadData(filters: Filters()) // do not filter tasted wines
            tastedWines = wineRepo.tastedWines.sorted(by: { $0.name < $1.name })
        } catch {
            alertInfo = AlertInfo(title: "Uh oh!", message: "We were unable to load your list.")
            isShowingAlert = true
        }
    }
    
    private func loadFilters() {
        try? filtersRepo.loadFilters()
        filters = filtersRepo.filters
    }
    
    func saveFilters() {
        try? filtersRepo.updateFilters(filters)
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
    
    func updateRating(rating: Int, for wine: Wine) {
        try? wineRepo.updateRating(rating: rating, for: wine)
        loadData()
    }
    
    func updateNotes(notes: String, for wine: Wine) {
        try? wineRepo.updateNotes(notes: notes, for: wine)
        loadData()
    }
    
    func winery(for wine: Wine) -> Booth? {
        return wineRepo.winery(for: wine)
    }
}
