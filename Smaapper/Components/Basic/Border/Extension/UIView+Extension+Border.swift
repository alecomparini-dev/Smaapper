//
//  UIView+Extension+Border.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 25/03/23.
//

import UIKit

extension UIView {
//    internal var border: Border { Border(self) }
}


//By teacher Caio Fabrini
extension CACornerMask {
    static public let bottomRight: CACornerMask = .layerMaxXMaxYCorner
    static public let bottomLeft: CACornerMask = .layerMinXMaxYCorner
    static public let topRight: CACornerMask = .layerMaxXMinYCorner
    static public let topLeft: CACornerMask = .layerMinXMinYCorner
}
