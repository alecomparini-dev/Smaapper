//
//  Dropdown.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 04/05/23.
//

import Foundation

struct Dropdow: Codable {
    let dropdown: [Dropdown]?

    enum CodingKeys: String, CodingKey {
        case dropdown = "dropdown"
    }
}
