//
//  DropdowMenuItem.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 03/05/23.
//

import Foundation

struct DropdownMenuItem: Codable {
    let title: String?
    let image: String?
    let subMenu: [DropdownMenuSection]?
    let trailing: String?
}

