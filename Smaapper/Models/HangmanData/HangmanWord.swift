//
//  HangmanWord.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/06/23.
//

import Foundation

struct HangmanWord: Codable {
    let word: String
    let syllables: [String]
    let subject: String
    let tips: [String]
}
