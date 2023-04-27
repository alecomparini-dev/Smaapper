//
//  BorderModel.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 25/03/23.
//

import UIKit

struct BorderModel {
    
    var radius: Int = 8
    var width: Int = 0
    var color: UIColor = .clear
    var choiceAffectedCorners: [Border.Corner] = [.top, .bottom]
    
}
