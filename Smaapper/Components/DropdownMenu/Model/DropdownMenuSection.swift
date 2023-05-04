//
//  DropdowSection.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 03/05/23.
//

import Foundation

typealias Dropdown = [DropdownMenuSection]

struct DropdownMenuSection: Codable {
    let section: String?
    let trailing: String?
    let items: [DropdownMenuItem]?
}
