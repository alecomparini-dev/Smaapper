//
//  SectionDropdownMenuModel.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/05/23.
//

import Foundation


typealias DropdownMenuData = [SectionDropdownMenuData]

struct SectionDropdownMenuData: Codable {
    let section: String?
    let trailing: String?
    let items: [RowDropdownMenuData]?
}
