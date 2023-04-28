//
//  ElevationWrapper.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/04/23.
//

import UIKit

class ElevationWrapper: View {
    
    private let component: UIView
    
    init(_ component: UIView) {
        self.component = component
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
    
//  MARK: - Private Function Area
    
    private func buildComponet3D() {
        let topShadow = createShadowLayer(.systemGray2.withAlphaComponent(0.15))
        topShadow.shadowOffset = CGSize(width: -2, height: -2)
        
        let bottomShadow = createShadowLayer(.black.withAlphaComponent(0.5))
        bottomShadow.shadowOffset = CGSize(width: 10, height: 6)
        
        layer.insertSublayer(topShadow, at: 0)
        layer.insertSublayer(bottomShadow, at: 0)
    }
    
    private func addComponent() {
        self.addSubview(component)
        component.applyConstraints { build in
            build.setWidth.setHeight.equalToSuperView
        }
    }
    
    
    private func createShadowLayer(_ color: UIColor) -> CAShapeLayer {
        var shadowLayer: CAShapeLayer!
        shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0,
                                                            width: self.frame.width ,
                                                            height: self.frame.height),
                                        cornerRadius: self.layer.cornerRadius).cgPath
        
        shadowLayer.fillColor = UIColor.clear.cgColor
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 8
        return shadowLayer
    }
    
}
