//
//  RealmError.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 11/07/23.
//

import Foundation

enum RealmError: Swift.Error {
    case write(id: Int = 2000, error: String)
}
