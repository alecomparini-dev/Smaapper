//
//  ButtonD3.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/04/23.
//

import UIKit


class Button3D: UIView {
    
    private let button: Button
    private var icon: UIImageView = UIImageView()
    


//  MARK: - Initializers
    
    init(_ icon: UIImageView) {
        self.icon = icon
        self.button = Button()
        super.init()
        buildButton3D()
    }
    
    override init(frame: CGRect) {
        self.button = Button()
        self.icon = UIImageView(image: UIImage(systemName: "square.stack.3d.forward.dottedline"))
        super.init(frame: frame)
        buildButton3D()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        buildButton3D()
        
    }
    
    
    //  MARK: - Properties
    
    
    
    
    private func buildButton3D() {
        
        let topShadow = createShadowLayer(.systemGray2.withAlphaComponent(0.1))
        topShadow.shadowOffset = CGSize(width: -2, height: -2)
        
        let bottomShadow = createShadowLayer(.black.withAlphaComponent(0.5))
        bottomShadow.shadowOffset = CGSize(width: 10, height: 6)
        
        layer.insertSublayer(topShadow, at: 0)
        layer.insertSublayer(bottomShadow, at: 0)
        
        _ = button.setTitle("C", .normal)
            .setTitleColor(.white, .normal)
            .setBorder({ build in
                build.setCornerRadius(self.layer.cornerRadius)
            })
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#22272e"),UIColor.HEX("#2d343d")])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
            .setBorder({ build in
                build.setColor(UIColor.HEX("#2d343d"))
                    .setWidth(2)
            })
        

        self.addSubview(button)
        button.applyConstraints { build in
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
        shadowLayer.shadowOpacity = 0.8
        shadowLayer.shadowRadius = 8
        return shadowLayer
    }
        
    
    
    
}
