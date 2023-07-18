//
//  WhatBeerService.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 18/07/23.
//

import UIKit

class WhatBeerService {
    typealias continuationWhatBeer = CheckedContinuation<WhatBeerData, Error>
    typealias continuationBeer = CheckedContinuation<BeerData?, Error>
    
    private let fileNameJson = K.WhatBeer.Service.fileNameJson
    private let extensionJson = K.WhatBeer.Service.extensionJson
    
    func fetchWhatBeerInJson() async throws -> WhatBeerData {
        return try await withCheckedThrowingContinuation({ continuation in
            fetchWhatBeerContinuation(continuation: continuation)
        })
    }
    
    func fetchBeerInJson(_ keyBeer: String) async throws -> BeerData? {
        return try await withCheckedThrowingContinuation({ continuation in
            fetchBeerContinuation(keyBeer, continuation: continuation)
        })
    }
    
    
//  MARK: - PRIVATE Area
    private func fetchWhatBeerContinuation(continuation: continuationWhatBeer) {
        do {
            let whatBeer: WhatBeerData = try FetchDataInJson().fetch(fileNameJson, extensionJson)
            continuation.resume(returning: whatBeer)
        } catch {
            continuation.resume(throwing: error)
        }
    }
    
    private func fetchBeerContinuation(_ keyBeer: String, continuation: continuationBeer) {
        do {
            let whatBeer: WhatBeerData = try FetchDataInJson().fetch(fileNameJson, extensionJson)
            let beer: BeerData? = whatBeer[keyBeer]
            continuation.resume(returning: beer)
        } catch {
            continuation.resume(throwing: error)
        }
    }
    
    

}
