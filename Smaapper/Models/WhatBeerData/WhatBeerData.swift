//
//  WhatBeerData.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 17/07/23.
//

import Foundation

typealias WhatBeerData = [String: BeerData]


// MARK: - WhatBeerDataValue
struct BeerData: Codable {
    let title: String
    let alcohol: Double
    let manufacturer: String
    let originated: OriginatedBeerData
    let nutritionalValues: NutritionalValuesBeerData
    let allergic: [String]

    enum CodingKeys: String, CodingKey {
        case title, alcohol, manufacturer, originated
        case nutritionalValues = "nutritional_values"
        case allergic
    }
}
