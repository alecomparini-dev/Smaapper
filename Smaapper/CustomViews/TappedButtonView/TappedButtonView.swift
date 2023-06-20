//
//  TappedButtonView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 20/06/23.
//

import UIKit

class TappedButtonView: UIView {
    private let identifier =  String(describing: TappedButtonView.self)
    private let keyPath = "shadowOpacity"
    
    private var shadowTapped: ShadowBuilder?
    private var shadowLayer: CALayer = CALayer()
    private var animation: CABasicAnimation = CABasicAnimation()
    private let component: UIView
    
    private(set) var isPressed: Bool = false
    
    init(_ component: UIView) {
        self.component = component
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var tapped: Void {
        createShadowTapped()
        createAnimation()
        setDelegate()
        addAnimationOnComponent()
        return
    }
    
    var pressed: Void {
        isPressed = true
        return
    }
    
    var unpressed: Void {
        isPressed = false
        return
    }
    
    
//  MARK: - PRIVATE Area
    private func setDelegate() {
        animation.delegate = self
    }
    
    private func createShadowTapped() {
        shadowTapped = ShadowBuilder(self.component)
                .setColor(Theme.shared.currentTheme.primary.adjustBrightness(20))
                .setOffset(width: 0, height: 0)
                .setOpacity(1)
                .setRadius(2)
                .setBringToFront()
                .setID(identifier)
                .apply()
    }
    
    private func removeShadowTapped() {
        component.removeShadowByID(identifier)
    }
    
    private func createAnimation() {
        animation = CABasicAnimation(keyPath: keyPath)
        animation.fromValue = 1.0
        animation.toValue = 1.0
        animation.duration = 0.2
        animation.isRemovedOnCompletion = true
    }
    
    private func addAnimationOnComponent() {
        if let layer = shadowTapped?.getShadowById(identifier) {
            self.shadowLayer = layer
            shadowLayer.add(animation, forKey: identifier)
        }
    }
    
    func removeShadowOpacityAnimation() {
        shadowLayer.removeAnimation(forKey: identifier)
    }
    
}


//  MARK: - EXTENSION CAAnimationDelegate
extension TappedButtonView: CAAnimationDelegate {
    
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        removeShadowTapped()
        removeShadowOpacityAnimation()
        shadowLayer.shadowOpacity = 0
    }
    
}
