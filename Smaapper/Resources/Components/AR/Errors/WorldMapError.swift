//
//  WorldMapError.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 11/07/23.
//

import Foundation

enum WorldMapError: Swift.Error {
    case getCurrentWordlMap(id: Int = 1000, error: String)
    case worldMapEmptyOrNil(id: Int = 1001)
    case convertToData(id: Int = 1002, error: String)
    case convertToWorldMap(id: Int = 1003, error: String)
    case invalidWorldMap(id: Int = 1004, error: String)
}
