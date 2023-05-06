//
//  ElevationWrapper.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/04/23.
//

import UIKit

class ElevationWrapper: View {
    
    private let _component: UIView
    
    init(_ component: UIView) {
        self._component = component
        super.init()
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        addComponent()
        DispatchQueue.main.async {
            self.buildComponet3D()
        }
    }
    
    var component: UIView { self._component }
    
//  MARK: - Private Function Area
    
    private func buildComponet3D() {
        let topShadow = createShadowLayer(.white.withAlphaComponent(0.13))
        topShadow.shadowOffset = CGSize(width: -5, height: -2)
        
        let bottomShadow = createShadowLayer(.black.withAlphaComponent(0.8))
        bottomShadow.shadowOffset = CGSize(width: 8, height: 8)
        
        layer.insertSublayer(topShadow, at: 0)
        layer.insertSublayer(bottomShadow, at: 0)
    }
    
    private func addComponent() {
        self.addSubview(component)
        component.makeConstraints { build in
            build.setWidth.setHeight.equalToSuperView
        }
    }
    
    
    private func createShadowLayer(_ color: UIColor) -> CAShapeLayer {
        let shadowLayer: CAShapeLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: component.bounds,
                                        cornerRadius: component.layer.cornerRadius).cgPath
        
        shadowLayer.fillColor = UIColor.clear.cgColor
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 8
        return shadowLayer
    }
    
}
