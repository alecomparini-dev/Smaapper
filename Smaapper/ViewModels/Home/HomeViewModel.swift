//
//  HomeViewModel.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/05/23.
//

import UIKit


class HomeViewModel {
    
    private let service: HomeService = HomeService()
    
    func fetchDropdownMenu(_ type: TypeFetch, completion: @escaping (_ result: DropdownMenuData?, _ error: Error?) -> Void) {
        switch type {
            
        case .file:
            service.getDropdownDataFromJson( completion: completion)
        
        case .api:
            break
            
        case .localStorage:
            break
        }
        
    }
    
    
}
