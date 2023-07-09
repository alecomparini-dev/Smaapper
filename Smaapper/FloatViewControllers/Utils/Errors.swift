//
//  Errors.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 06/07/23.
//

import Foundation

enum TypeErrorWorldMap {
    case getWordlMap
    case worldMapEmptyOrNil
    case convertToData
    case convertToWorldMap
}

enum Error: Swift.Error {
    case fileNotFound(error: String)
    case fileDecodingFailed(error: String, Swift.Error)
    case worldMap(typeError: TypeErrorWorldMap, error: String)
}
