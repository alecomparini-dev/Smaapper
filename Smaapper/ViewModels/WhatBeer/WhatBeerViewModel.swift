//
//  WhatBeerViewModel.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 18/07/23.
//

import UIKit

class WhatBeerViewModel {
    
    private let service: WhatBeerService
    
    init(service: WhatBeerService) {
        self.service = service
    }
    
    func fetchWhatBeer(_ type: TypeFetch) async throws -> WhatBeerData? {
        switch type {
            case .file:
                return try await service.fetchWhatBeerFromJSON()
                
            case .api:
                break
                
            case .localStorage:
                break
        }
        return nil
    }
    
    func fetchBeer(_ type: TypeFetch, _ keyBeer: String) async throws -> BeerData? {
        switch type {
            case .file:
                return try await service.fetchBeerFromJSON(keyBeer)
                
            case .api:
                break
                
            case .localStorage:
                break
        }
        return nil
    }
    
    
}
