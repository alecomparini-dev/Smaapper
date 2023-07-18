//
//  HomeService.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/05/23.
//

import Foundation

class HomeService: GenericService {
    
    private let fileNameJson = K.Home.Service.fileNameJson
    private let extensionJson = K.Home.Service.extensionJson
    
    func getDropdownDataFromJson(completion: @escaping completionService<DropdownMenuData>) {
        do {
            let result: DropdownMenuData = try FetchDataInJson().fetch(fileNameJson, extensionJson)
            completion(result, nil)
        } catch {
            completion(nil, error)
        }
    }
    
}
