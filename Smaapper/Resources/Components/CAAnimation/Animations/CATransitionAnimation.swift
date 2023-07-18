//
//  CATransitionAnimation.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 17/07/23.
//

import UIKit

class CATransitionAnimation: CATransition {
    
    private var id: String = kCATransition
    private var layer: CALayer?

    override init() {
        super.init()
        initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        setIsRemovedOnCompletion(true)
        delegate = self
    }
    
    
//  MARK: - SET Properties

    @discardableResult
    func setID(_ id: String) -> Self {
        self.id = id
        return self
    }
    
    @discardableResult
    func setDuration(_ duration: Double) -> Self {
        self.duration = duration
        return self
    }
    
    @discardableResult
    func setTimingFunction(_ timing: CAMediaTimingFunctionName) -> Self {
        self.timingFunction = CAMediaTimingFunction(name: timing)
        return self
    }
    
    @discardableResult
    func setType(_ type: CATransitionType) -> Self {
        self.type = type
        return self
    }
    
    @discardableResult
    func setSubtype(_ subType: CATransitionSubtype) -> Self {
        self.subtype = subType
        return self
    }
    
    @discardableResult
    func setIsRemovedOnCompletion(_ removed: Bool) -> Self {
        self.isRemovedOnCompletion = removed
        return self
    }
    
    
//  MARK: - PLAY Animation
    @discardableResult
    func play(_ layer: CALayer) -> Self {
        self.layer = layer
        layer.add(self, forKey: id)
        return self
    }

    @discardableResult
    func play(_ component: UIView) -> Self {
        play(component.layer)
        return self
    }
    
}


//  MARK: - EXTENSION CAAnimationDelegate
extension CATransitionAnimation: CAAnimationDelegate {
    
    func animationDidStart(_ anim: CAAnimation) {}
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("entrou chamou")
        if flag {
            if let layer {
                print("removeu")
                layer.removeAnimation(forKey: self.id)
            }
        }
    }
    
}





