//
//  GradientModel.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 31/03/23.
//

import UIKit

struct GradientModel {
    var color: [UIColor] = []
    var direction: Gradient.Direction = .leftToRight
    var point: CGPoint = CGPoint(x: 0.5, y: 0.5) // only use for conic and radial type
    var type: CAGradientLayerType = .axial
}

