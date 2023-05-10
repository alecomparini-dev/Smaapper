//
//  RowDropdownMenuModel.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/05/23.
//

import Foundation

struct RowDropdownMenuModel: Codable {
    let title: String?
    let leftImage: String?
    let rightImage: String?
    let subMenu: [SectionDropdownMenuModel]?
}
