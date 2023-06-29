//
//  ShowBodyPartAnimation.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 29/06/23.
//

import UIKit

class ShowBodyPartAnimation {

    static func show(_ bodyPart: UIView, alpha: (start: CGFloat, end: CGFloat) = (1,0)) {
        bodyPart.alpha = alpha.start
        UIView.animate(withDuration: 1, delay: 0.5 , options: .curveEaseInOut, animations: {
            bodyPart.alpha = alpha.end
        })
    }

    
}

