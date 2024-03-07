//
//  RawParserRepository.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/7/24.
//

import Foundation

class RawParserRepository: RawParserRepositoryProtocol {
    
    // MARK: - Properties
    
    private(set) var booths: Booths
    private(set) var fileService: FileServiceProtocol
    
    // MARK: - Init
    
    init(fileService: FileServiceProtocol = FileService()) {
        self.booths = Booths()
        self.fileService = fileService
    }
    
    // MARK: - Loading
    
    func loadAndParseData() throws {
        let text = try fileService.loadText(with: "wines_raw")
        try parseText(text)
    }
    
    private func parseText(_ text: String) throws {
        booths.removeAll()
        
        let boothTexts = text.components(separatedBy: "\n\n")
        for curBoothText in boothTexts {
            var boothNumber: String?
            var boothName: String?
            var countries = Countries()
            var wines = Wines()
            let boothComponents = curBoothText.components(separatedBy: "\n")
            for (i, boothComponent) in boothComponents.enumerated() {
                if i == 0 {
                    // first line is the booth info
                    let boothInfo = boothComponent.components(separatedBy: " ~ ")
                    // booth number and name
                    boothNumber = boothInfo[0]
                    boothName = boothInfo[1]
                    // countries
                    if boothInfo.count > 2 {
                        let boothCountries = boothInfo[2]
                        let countryTexts = boothCountries.components(separatedBy: ",")
                        for curCountryText in countryTexts {
                            if !curCountryText.isEmpty {
                                if let country = Country(rawValue: curCountryText) {
                                    countries.append(country)
                                } else {
                                    throw RepoError.failedToDecode
                                }
                            }
                        }
                    }
                } else {
                    // after the first line, we're parsing wines
                    let yearExtraction = boothComponent.components(separatedBy: " ")
                    // get the year from the wine line
                    if let wineYear = yearExtraction.first {
                        // remove the year and trailing space
                        let wineInfo = boothComponent.replacingOccurrences(of: "\(wineYear) ", with: "")
                        // split on ^^ to get the name and any medal
                        let wineComponents = wineInfo.components(separatedBy: "^^")
                        if let wineName = wineComponents.first {
                            var wineMedal = Medal.none
                            if wineComponents.count > 1 {
                                let medalLetter = wineComponents[1]
                                if medalLetter == "g" {
                                    wineMedal = .gold
                                } else if medalLetter == "s" {
                                    wineMedal = .silver
                                } else if medalLetter == "b" {
                                    wineMedal = .bronze
                                }
                            }
                            let wine = Wine(year: wineYear,
                                            name: wineName,
                                            medal: wineMedal)
                            wines.append(wine)
                        } else {
                            throw RepoError.failedToDecode
                        }
                    } else {
                        throw RepoError.failedToDecode
                    }
                }
            }
            
            // add booth
            if let boothNumber = boothNumber,
               let boothName = boothName {
                let booth = Booth(number: boothNumber,
                                  name: boothName,
                                  type: .wine,
                                  countries: countries,
                                  wines: wines)
                booths.append(booth)
            } else {
                throw RepoError.failedToDecode
            }
        }
    }
    
    // MARK: - Printing
    
    func printData() throws {
        guard let data = try? JSONEncoder().encode(booths) else {
            throw RepoError.failedToEncode
        }
        
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
           let prettyPrintedData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
           let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8) {
            print(prettyPrintedString)
        } else {
            throw RepoError.failedToEncode
        }
    }
}
