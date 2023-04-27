//
//  GradientViewModel.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 31/03/23.
//

import UIKit

struct GradientViewModel {

    private var model = GradientModel()
    
    var color: [UIColor] {
        get { model.color }
        set { model.color.append(contentsOf: newValue)  }
    }
    
    var direction: Gradient.Direction {
        get { model.direction }
        set { model.direction = newValue }
    }
    
    var point: CGPoint {
        get { model.point }
        set { model.point = newValue }
    }
    
    var type: CAGradientLayerType {
        get { model.type }
        set { model.type = newValue }
    }
    
}
