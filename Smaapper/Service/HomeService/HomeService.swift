//
//  HomeService.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/05/23.
//

import Foundation

class HomeService: GenericService {
    
    private let fileNameJson = "DropdownMenuData"
    private let extensionJson = "json"
    
    
    func getDropdownDataFromJson(completion: @escaping completion<DropdownMenuData>) {
        if let jsonFileUrl = Bundle.main.url(forResource: fileNameJson, withExtension: extensionJson) {
            do {
                let jsonData = try Data(contentsOf: jsonFileUrl)
                let result = try JSONDecoder().decode(DropdownMenuData.self, from: jsonData)
                completion(result, nil)
            } catch {
                completion(nil, Error.fileDecodingFailed(name: fileNameJson , error))
            }
        } else {
            completion(nil, Error.fileNotFound(name: fileNameJson))
        }
    }
    
    
}
