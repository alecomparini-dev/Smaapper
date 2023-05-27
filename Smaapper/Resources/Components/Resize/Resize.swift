//
//  Resize.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 04/05/23.
//

import UIKit

class Resize {
    
    static func resize(_ comp: UIView) {
        comp.layer.sublayers?.forEach({ layer in
            if layer.shadowOpacity > 0 {
                layer.shadowPath = comp.replicateFormat().cgPath
                return
            }
            if layer is CAShapeLayer {
                (layer as! CAShapeLayer).path = comp.replicateFormat().cgPath
                return
            }
            if layer is CAGradientLayer {
                guard let layer = layer as? CAGradientLayer else { return }
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                layer.frame = comp.bounds
                layer.maskedCorners = comp.layer.maskedCorners
                CATransaction.commit()
                return
            }
        })
    }
    
}




