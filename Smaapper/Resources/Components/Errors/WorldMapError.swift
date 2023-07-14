//
//  WorldMapError.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 11/07/23.
//

import Foundation

enum WorldMapError: Swift.Error {
    case getCurrentWordlMap(error: String)
    case worldMapEmptyOrNil
    case convertToData(error: String)
    case convertToWorldMap(error: String)
    case invalidWorldMap(error: String)
}
