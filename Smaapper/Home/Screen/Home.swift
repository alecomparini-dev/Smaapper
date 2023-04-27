//
//  Home.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/04/23.
//

import UIKit

class Home: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.HEX("#1c1e20")
        _ = self.setGradient { build in
            build
                .setColor([UIColor.HEX("#1c1e20"), UIColor.HEX("#1c1e20"),  UIColor.HEX("#27292c")])
                .setAxialGradient(.leftTopToRightBottom)
                .apply()
        }
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var floatButton: UIButton = {
        let floatButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        floatButton.center = CGPoint(x: bounds.width - 50, y: bounds.height - 50)
        floatButton.backgroundColor = .blue
        floatButton.layer.cornerRadius = 30
        floatButton.layer.shadowOpacity = 0.5
        floatButton.layer.shadowRadius = 5
        floatButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        return floatButton
    }()
    
    
    lazy var buttomTest: Button = {
        let btn = Button("TESTE")
            .setHeight(50)
            .setWidth(250)
            .setShadow { build in
                build
                    .setColor(.black)
                    .setOffset(width: 3, height: 5)
                    .setRadius(1)
            }
            .setBorder { build in
                build
                    .setCornerRadius(18)
                    .setColor(.white.withAlphaComponent(0.5))
                    .setWidth(0.5)
            }
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.setHorizontalAlignmentX.equalToSuperView
//                    .setBottom.equalToSafeArea(-1)
                    .setHorizontalAlignmentX.equalToSafeArea
//                    .setTrailing.setLeading.equalToSafeArea(30)
            }
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#f92900"),UIColor.HEX("#b02300")])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
        return btn
    }()
    
    lazy var buttomTest2: Button = {
        let btn = Button("TESTE3")

            .setBorder { build in
                build
                    .setCornerRadius(18)
                    .setColor(.white.withAlphaComponent(0.5))
                    .setWidth(0.5)
            }
            .setConstraints { build in
                build
//                    .setVerticalAlignmentY.setHorizontalAlignmentX.equalToSuperView
                    .setBottom.equalToSafeArea(-10)
                    .setTrailing.setLeading.equalToSafeArea(30)
                    .setHeight.equalToConstant(60)
            }
            .setBackgroundColor(.yellow)
        return btn
    }()
    
    
    lazy var buttomTest3D: Converter3D = {
        let btn = Converter3D(UIImageView(image: UIImage(systemName: "square.stack.3d.forward.dottedline")))
            .setComponent(Button()
                .setBorder { build in
                    build.setCornerRadius(15)
                        .setColor(UIColor.HEX("#2d343d"))
                        .setWidth(2)
                }
                .setTitle("C", .normal)
                .setTitleColor(.white, .normal)
                .setGradient { build in
                    build
                        .setColor([UIColor.HEX("#22272e"),UIColor.HEX("#2d343d")])
                        .setAxialGradient(.leftTopToRightBottom)
                        .apply()
                }
                .setBackgroundColor(.red)
                .addTarget(self, #selector(didTapFloatingButton), .touchUpInside)
            )
            .setConstraints { build in
                build.setBottom.equalToSafeArea(-15)
                    .setTrailing.equalToSafeArea(-20)
                    .setHeight.equalToConstant(50)
                    .setWidth.equalToConstant(50)
            }
        return btn
    }()
    @objc func didTapFloatingButton() {
            // Ação do botão flutuante
            print("Floating button tapped!")
        }

    private func addElements() {
        buttomTest.add(insideTo: self)
        buttomTest.applyConstraint()
        

//        floatButton.add(insideTo: self)
//        floatButton.applyConstraints { build in
//            build.setBottom.equalToSafeArea(-15)
//                .setTrailing.equalToSafeArea(-15)
//                .setHeight.setWidth.equalToConstant(50)
//        }
//        buttomTest2.add(insideTo: self)
//        buttomTest2.applyConstraint()
        
        buttomTest3D.add(insideTo: self)
        buttomTest3D.applyConstraint()

        
        
        bringSubviewToFront(buttomTest)
        
        
        
        
        
        
        
        
        
        let myButton = UIButton(type: .system)
        myButton.setTitle("Teste", for: .normal)
        myButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        myButton.setTitleColor(.black, for: .normal)

        let buttonHeight: CGFloat = 50
        let buttonWidth: CGFloat = 150

        myButton.frame = CGRect(x: 50, y: 50, width: buttonWidth, height: buttonHeight)

        let topShadowLayer = CALayer()
        topShadowLayer.frame = CGRect(x: 0, y: -10, width: buttonWidth, height: buttonHeight + 10)
        topShadowLayer.backgroundColor = UIColor.clear.cgColor
        topShadowLayer.shadowColor = UIColor.white.cgColor
        topShadowLayer.shadowOffset = CGSize(width: 0, height: -5)
        topShadowLayer.shadowOpacity = 1.0
        topShadowLayer.shadowRadius = 5

        let bottomShadowLayer = CALayer()
        bottomShadowLayer.frame = CGRect(x: 0, y: buttonHeight, width: buttonWidth, height: 10)
        bottomShadowLayer.backgroundColor = UIColor.clear.cgColor
        bottomShadowLayer.shadowColor = UIColor.yellow.cgColor
        bottomShadowLayer.shadowOffset = CGSize(width: 0, height: 5)
        bottomShadowLayer.shadowOpacity = 1.0
        bottomShadowLayer.shadowRadius = 5

        myButton.layer.insertSublayer(bottomShadowLayer, at: 0)
        myButton.layer.insertSublayer(topShadowLayer, at: 0)

        
        
        
        myButton.add(insideTo: self)
        myButton.applyConstraints { build in
            build.setTop.setLeading.setTrailing.equalToSafeArea(10)
                .setHeight.equalToConstant(60)
        }
        
        
        
        
        
        
    }
}
