//
//  ValidatePercent.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 28/05/23.
//

import Foundation

struct ValidatePercent {
    
    static func validate(_ percent: CGFloat) -> Bool {
        if !(0.0...100.0).contains(percent) {
            return false
        }
        return true
    }
    
}
