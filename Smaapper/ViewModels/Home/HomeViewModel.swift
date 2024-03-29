//
//  HomeViewModel.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/05/23.
//

import UIKit


class HomeViewModel {
    
    private let service: HomeService
    
    init(service: HomeService) {
        self.service = service
    }
    
    func fetchDropdownMenu(_ type: TypeFetch, completion: @escaping (_ result: DropdownMenuData?, _ error: Error?) -> Void) {
        switch type {
            
        case .file:
            service.getDropdownDataFromJSON( completion: completion)
        
        case .api:
            break
            
        case .localStorage:
            break
        }
        
    }
    
    
}
