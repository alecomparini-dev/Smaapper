//
//  CATransitionAnimation.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 17/07/23.
//

import UIKit

class CATransitionAnimation: CATransition {
    typealias completionAnimation = () -> Void
    
    private var id: String = kCATransition
    private var layer: CALayer?
    private var completion: completionAnimation?
    
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
    func play(_ layer: CALayer, completion: completionAnimation? = nil) -> Self {
        self.layer = layer
        self.completion = completion
        layer.add(self, forKey: id)
        return self
    }
    
    @discardableResult
    func play(_ component: UIView, completion: completionAnimation? = nil) -> Self {
        play(component.layer, completion: completion)
        return self
    }
    
    
//  MARK: - ACTIONS Area
    func removeCAAnimation(id: String) {
        layer?.removeAnimation(forKey: id)
    }
    
    func removeAllAnimation(id: String) {
        layer?.removeAllAnimations()
    }
}


//  MARK: - EXTENSION CAAnimationDelegate
extension CATransitionAnimation: CAAnimationDelegate {
    
    func animationDidStart(_ anim: CAAnimation) {}
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            if let layer {
                layer.removeAnimation(forKey: self.id)
            }
        }
        self.completion?()
    }
    
}





