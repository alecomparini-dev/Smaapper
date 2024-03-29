//
//  FileError.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 06/07/23.
//

import Foundation


enum FileError: Swift.Error {
    case fileNotFound(error: String)
    case fileDecodingFailed(error: String, Swift.Error)
}
