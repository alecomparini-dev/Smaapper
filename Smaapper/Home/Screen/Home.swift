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
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var buttom1: Button = {
        let btn = Button("BUTTON 1")
            .setHeight(50)
            .setWidth(280)
            .setActivateDisabledButton(false)
            .setShadow { build in
                build
                    .setColor(.black)
                    .setOffset(width: 5, height: 5)
                    .setRadius(1)
                    .apply()
            }
            .setBorder { build in
                build
                    .setCornerRadius(18)
                    .setColor(.white.withAlphaComponent(0.5))
                    .setWidth(0.5)
            }
            .setConstraints { build in
                build
//                    .setVerticalAlignmentY.setHorizontalAlignmentX.equalToSuperView
                                    .setBottom.equalToSafeArea(-1)
                    .setHorizontalAlignmentX.equalToSafeArea
                //                    .setTrailing.setLeading.equalToSafeArea(30)
            }
            .setGradient { build in
                build
//                    .setColor([UIColor.HEX("#13547a"),UIColor.HEX("#50827c")]) // -> Aqua Splash
//                    .setColor([UIColor.HEX("#df667b"),UIColor.HEX("#df6e9d")]) // -> Passionate Bed
//                    .setColor([UIColor.HEX("#09203f"),UIColor.HEX("#3e5a70")]) // -> Eternal Constance
//                    .setColor([UIColor.HEX("#009245"),UIColor.HEX("#FCEE21")]) // -> Luscious Lime
//                    .setColor([UIColor.HEX("#662D8C"),UIColor.HEX("#ED1E79")]) // -> Purple Lake **
//                    .setColor([UIColor.HEX("#ED1E79"),UIColor.HEX("#662D8C")]) // -> Purple Lake INVERTIDO** <-
//                    .setColor([UIColor.HEX("#614385"),UIColor.HEX("#516395")]) // -> Kashmir *
//                    .setColor([UIColor.HEX("#067D68"),UIColor.HEX("#50D5B7")]) // -> PENSAR
//                    .setColor([UIColor.HEX("#2E3192"),UIColor.HEX("#1BFFFF")]) // -> Ocean Blue
//                    .setColor([UIColor.HEX("#667eea"),UIColor.HEX("#764ba2")]) // -> Plum Plate *****
//                    .setColor([UIColor.HEX("#ec9355"),UIColor.HEX("#ff6b00")]) // --> top demaisssssss
//                    .setColor([UIColor.HEX("#f92900"),UIColor.HEX("#b02300")]) //--> Favorito de todos
                    .setColor([UIColor.HEX("#FF512F"),UIColor.HEX("#DD2476")]) // -> Bloody Mary VENCEDOR
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
        return btn
    }()
    
    lazy var view: View = {
        let view = View()
            .setConstraints { build in
                build.setTop.setLeading.setTrailing.setBottom.equalToSuperView
            }
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#1c1e20"), UIColor.HEX("#1c1e20"),  UIColor.HEX("#27292c")])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
        
        return view
    }()
    
    
    
    lazy var buttomLaranja: Button = {
        let btn = Button("HEADSET")
            .setFont(UIFont.systemFont(ofSize: 21))
            .setTitleWeight(.black)
            .setHeight(100)
            .setTitleAlignment(.left)
            .setWidth(170)
            .setTitleColor(UIColor.HEX("#000000").withAlphaComponent(0.3) , .normal)
            .setActivateDisabledButton(false)
            .setBorder({ build in
                build.setCornerRadius(20)
                    .setColor(UIColor.HEX("#f57f16").withAlphaComponent(0.5))
                    .setWidth(2)
                
            })
            .setShadow { build in
                build
                    .setColor(UIColor.HEX("#ed8f4b").withAlphaComponent(0.5))
                    .setOffset(width: -2, height: -2)
                    .setOpacity(1)
                    .setRadius(20)
                    .apply()
            }
            .setShadow { build in
                build
                    .setColor(UIColor.HEX("#000000").withAlphaComponent(0.8))
                    .setOffset(width: 5, height: 5)
                    .setRadius(1)
                    .apply()
            }
//            .setShadow { build in
//                build
//                    .setColor(UIColor.HEX("#FFFFFF").withAlphaComponent(0.2))
//                    .setOffset(width: 0, height: 0)
//                    .setOpacity(1)
//                    .setRadius(10)
//                    .apply()
//            }
            .setConstraints { build in
                build
//                    .setTop.equalTo(buttom1, .bottom, 20)
                    .setVerticalAlignmentY.equalToSuperView
                    .setLeading.equalToSafeArea(40)
            }
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#ec9355"),UIColor.HEX("#ff6b00")])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }

        return btn
    }()
    
    //TODO: - FAZERRRRRR O WEIGHT DA IMAGEM !!!!!!!!!
    lazy var botaozim: ButtonImage = {
        let btn = ButtonImage(UIImageView(image: UIImage(systemName: "chevron.right")))
            .setImageSize(13)
            .setTitleWeight(.black)
            .setHeight(45)
            .setWidth(45)
            .setTitleColor(UIColor.HEX("#FFFFFF") , .normal)
            .setBorder({ build in
                build.setCornerRadius(22.5)
            })
            .setShadow { build in
                build
                    .setColor(UIColor.HEX("#ed8f4b").withAlphaComponent(0.3))
                    .setOffset(width: -5, height: -4)
                    .setOpacity(1)
                    .setRadius(8)
                    .apply()
            }
            .setShadow { build in
                build
                    .setColor(UIColor.HEX("#000000").withAlphaComponent(0.8))
                    .setOffset(width: 3, height: 3)
                    .setRadius(3)
                    .apply()
            }
            .setShadow { build in
                build
                    .setColor(UIColor.HEX("#FFFFFF").withAlphaComponent(0.2))
                    .setOffset(width: 0, height: 0)
                    .setOpacity(1)
                    .setRadius(10)
                    .apply()
            }
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#ec9355"),UIColor.HEX("#ff6b00")])
                    .setColor([UIColor.HEX("#f92900"),UIColor.HEX("#b02300")])
                    .setAxialGradient(.rightBottomToLeftTop)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(buttomLaranja)
//                    .setVerticalAlignmentY.equalToSuperView
                    .setLeading.equalTo(buttomLaranja, .trailing, 50)
            }
        return btn
    }()
    
    lazy var buttomTest3D: Button3D = {
        let btn = Button3D()
            .setConstraints { build in
                build.setBottom.equalToSafeArea(-1)
                    .setTrailing.equalToSafeArea(-20)
                    .setHeight.equalToConstant(50)
                    .setWidth.equalToConstant(50)
            }
        return btn
    }()
    @objc func didTapFloatingButton() {
        print("Floating button tapped!")
        buttom1.isEnabled = !buttom1.isEnabled
        buttomDownload.isEnabled = !buttomDownload.isEnabled
    }
    
    
    lazy var buttomDownload: ButtonImage = {
        let btn = ButtonImage(UIImageView(image: UIImage(systemName: "arrow.down.to.line")))
            .setTitle("Download", .normal)
            .setHeight(45)
            .setWidth(180)
            .setImageSize(50)
            .setPadding(5)
            .setActivateDisabledButton(false)
            .setBorder { build in
                build
                    .setCornerRadius(20)
                    .setColor(.white.withAlphaComponent(0.5))
                    .setWidth(0.5)
            }
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(10)
                    .setTrailing.equalToSafeArea(-10)
            }
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#ed56ff"),UIColor.HEX("#b023ff")])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
            .setShadow { build in
                build
                    .setColor(.black)
                    .setOffset(width: 5, height: 5)
                    .setRadius(1)
                    .apply()
            }

        return btn
    }()
    
    
    private func addElements() {
        
//        buttom1.layer.zPosition = 10000
        
        view.add(insideTo: self)
        view.applyConstraint()
        
        
        buttomDownload.add(insideTo: self)
        buttomDownload.applyConstraint()
        
        
        buttomTest3D.add(insideTo: self)
        buttomTest3D.applyConstraint()
        
        buttom1.add(insideTo: self)
        buttom1.applyConstraint()
        

        
        
        buttomLaranja.add(insideTo: self)
        buttomLaranja.applyConstraint()
        
        botaozim.add(insideTo: self)
        botaozim.applyConstraint()
        
//        bringSubviewToFront(buttomIMAGE)
        
        
        
    }
    
}

