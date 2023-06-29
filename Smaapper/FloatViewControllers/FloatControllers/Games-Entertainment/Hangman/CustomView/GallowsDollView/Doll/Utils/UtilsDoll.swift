//
//  UtilsDoll.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 29/06/23.
//

import UIKit

class UtilsDoll {

    static func showBodyPartAnimation(_ bodyPart: UIView, alpha: (start: CGFloat, end: CGFloat) = (1,0), completion: (()->Void)? = nil) {
        bodyPart.alpha = alpha.start
        UIView.animate(withDuration: 1, delay: 0.5 , options: .curveEaseInOut, animations: {
            bodyPart.alpha = alpha.end
        }, completion: { _ in
            completion?()
        })
    }
    
    static func successAnimation(_ bodyPart: UIView, _ positionY: CGFloat, completion: (()->Void)? = nil) {
        UIView.animate(withDuration: 1, delay: 0.5 , options: .curveEaseInOut, animations: {
            bodyPart.frame.origin.y = positionY
        }, completion: { _ in
            completion?()
        })
    }
    
    static func transitionImageAnimation(_ imageView: UIImageView, _ image: String) {
        UIView.transition(with: imageView, duration: 1, options: .transitionCrossDissolve, animations: {
            imageView.image = UIImage(systemName: image)
        }, completion: nil)
    }
    
}

