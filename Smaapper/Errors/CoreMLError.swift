//
//  CoreMLError.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 14/07/23.
//

import Foundation

enum CoreMLError: Swift.Error {
    case loadBeerModel(error: String)
    case convertToCIImage(error: String)
}
