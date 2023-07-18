//
//  FetchDataInJson.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 18/07/23.
//

import Foundation


struct FetchDataInJson {
    
    func fetch<T: Codable>(_ fileNameJson: String, _ extensionJson: String) throws -> T {
        do {
            let jsonData = try getData(fileNameJson, extensionJson)
            let result = try JSONDecoder().decode(T.self, from: jsonData)
            return result
        } catch let error {
            throw FileError.fileDecodingFailed(error: fileNameJson, error)
        }        
    }
    
    func getData(_ fileNameJson: String, _ extensionJson: String) throws -> Data {
        if let jsonFileUrl = Bundle.main.url(forResource: fileNameJson, withExtension: extensionJson) {
            do {
                return try Data(contentsOf: jsonFileUrl)
            } catch let error {
                throw FileError.fileDecodingFailed(error: fileNameJson, error)
            }
        } else {
            throw FileError.fileNotFound(error: fileNameJson)
        }
    }
    
}
