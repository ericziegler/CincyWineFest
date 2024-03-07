//
//  WinesViewModel.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/4/24.
//

import Foundation

class WinesViewModel: ObservableObject {
    
    // MARK: - BEGIN TEMP
    
    let rawParser = RawParserRepository()
    let boothRepo = BoothRepository()
    
    func loadRawData() {
        do {
            try rawParser.loadAndParseData()
        } catch {
            print(error)
        }
    }
    
    func saveData() {
        do {
            try rawParser.printData()
        } catch {
            print(error)
        }
    }
    
    func loadBooths() {
        do {
            try boothRepo.loadBooths()
        } catch {
            print(error)
        }
    }
    
    // MARK: - END TEMP
    
}
