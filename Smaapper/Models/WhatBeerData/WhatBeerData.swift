//
//  WhatBeerData.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 17/07/23.
//

import Foundation

typealias WhatBeerData = [String: WhatBeerDataValue]


// MARK: - WhatBeerDataValue
struct WhatBeerDataValue: Codable {
    let alcohol: Double
    let manufacturer: String
    let originated: OriginatedData
    let allergic: [String]
}


