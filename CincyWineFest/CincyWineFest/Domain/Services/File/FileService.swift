//
//  FileService.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/7/24.
//

import Foundation

class FileService: FileServiceProtocol {
 
    func loadData(with fileName: String) throws -> Data {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            throw RepoError.noDataFound
        }

        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            return data
        } catch {
            throw RepoError.failedToLoad
        }
    }
    
    func loadText(with fileName: String) throws -> String {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else {
            throw RepoError.noDataFound
        }

        do {
            let url = URL(fileURLWithPath: path)
            let text = try String(contentsOf: url, encoding: .utf8)
            return text
        } catch {
            throw RepoError.failedToLoad
        }
    }
    
}
