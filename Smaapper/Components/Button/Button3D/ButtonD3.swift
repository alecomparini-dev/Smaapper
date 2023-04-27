//
//  ButtonD3.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/04/23.
//

import UIKit


class Converter3D: View {
    
    private var icon: UIImageView = UIImageView()
    
    
    //  MARK: - Initializers
    
    
    init(_ icon: UIImageView) {
        self.icon = icon
        super.init()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //  MARK: - Properties
    func setComponent(_ component: UIView) -> Self {
        self.addSubview(component)
        component.applyConstraints { build in
            build.setWidth.setHeight.equalToSuperView
        }
        DispatchQueue.main.async {
            self.buildButton3D()
        }
        return self
    }
    
    
    
    private func buildButton3D() {
        let topShadow = createShadowLayer(.systemGray2.withAlphaComponent(0.15))
        topShadow.shadowOffset = CGSize(width: -2, height: -2)
        
        let bottomShadow = createShadowLayer(.black.withAlphaComponent(0.5))
        bottomShadow.shadowOffset = CGSize(width: 10, height: 6)
        
        layer.insertSublayer(topShadow, at: 0)
        layer.insertSublayer(bottomShadow, at: 0)

        
//
//
//        _ = button.setTitle("C", .normal)
//            .setTitleColor(.white, .normal)
//            .setBorder({ build in
//                build.setCornerRadius(15)
//            })
//            .setGradient { build in
//                build
//                    .setColor([UIColor.HEX("#22272e"),UIColor.HEX("#2d343d")])
//                    .setAxialGradient(.leftTopToRightBottom)
//                    .apply()
//            }
//            .setBorder({ build in
//                build.setColor(UIColor.HEX("#2d343d"))
//                    .setWidth(2)
//            })
//
//
//        self.addSubview(button)
//        button.applyConstraints { build in
//            build.setWidth.setHeight.equalToSuperView
//        }
        
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
    
    private func createShadowLayer2(_ color: UIColor) -> CALayer {
        var shadowLayer: CALayer!
        shadowLayer = CALayer()
        
        
        shadowLayer.cornerRadius = self.layer.cornerRadius
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 5)
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 8
        return shadowLayer
    }
    
    
    
    
}
