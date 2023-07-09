//
//  Double+Extensions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 02/07/23.
//

import Foundation

extension Double {
    var degreesToPI: Double { self * (Double.pi/180) }
    
    var piToDegrees: Double { self * (180/Double.pi) }
}
