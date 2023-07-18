//
//  FetchDataInJson.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 18/07/23.
//

import Foundation


struct FetchDataInJson {
    
    func fetch<T: Codable>(_ fileNameJson: String, _ extensionJson: String) throws -> T {
        if let jsonFileUrl = Bundle.main.url(forResource: fileNameJson, withExtension: extensionJson) {
            do {
                let jsonData = try Data(contentsOf: jsonFileUrl)
                let result = try JSONDecoder().decode(T.self, from: jsonData)
                return result
            } catch let error {
                throw FileError.fileDecodingFailed(error: fileNameJson, error)
            }
        } else {
            throw FileError.fileNotFound(error: fileNameJson)
        }
    }
    
}
