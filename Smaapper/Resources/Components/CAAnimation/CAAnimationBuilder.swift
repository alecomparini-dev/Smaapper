//
//  CAAnimationBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 17/07/23.
//

import UIKit

class CAAnimationBuilder {
    
    private(set) var transition: CATransitionAnimation?
    
    func setTransitionAnimation(_ animation: (_ build: CATransitionAnimation) -> CATransitionAnimation) -> Self {
        self.transition = animation(CATransitionAnimation())
        return self
    }
    
    func setBasicAnimation() {
        
    }
    
}


