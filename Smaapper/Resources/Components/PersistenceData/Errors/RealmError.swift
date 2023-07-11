//
//  RealmError.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 11/07/23.
//

import Foundation

enum RealmError: Swift.Error {
    case insert(id: Int = 2000, error: String)
    case findByCustomColumn(id: Int = 2001, error: String)
}
