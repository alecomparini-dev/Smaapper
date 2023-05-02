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
                    .setHeight.equalToConstant(50)
                    .setWidth.equalToConstant(280)
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
            .setTitleAlignment(.left)
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
            .setConstraints { build in
                build
//                    .setTop.equalTo(buttom1, .bottom, 20)
                    .setVerticalAlignmentY.equalToSuperView
                    .setLeading.equalToSafeArea(40)
                    .setHeight.equalToConstant(100)
                    .setWidth.equalToConstant(170)
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
                    .setHeight.setWidth.equalToConstant(45)
            }
        return btn
    }()
    
    lazy var buttom3D: Button3D = {
        let btn = Button3D(UIImageView(image: UIImage(systemName: "mic.fill")))
            .setBorder({ build in
                build.setCornerRadius(12)
            })
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#22272e"),UIColor.HEX("#2d343d")])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
            .setConstraints { build in
                build.setBottom.equalToSafeArea(-101)
                    .setLeading.equalToSafeArea(20)
                    .setHeight.equalToConstant(50)
                    .setWidth.equalToConstant(50)
            }
            .addTarget(self, #selector(didTapFloatingButton), .touchUpInside)
        return btn
    }()
    
    @objc func didTapFloatingButton() {
        print("Floating button tapped!")
        _ = floatButton.setShadow { build in
            build.setColor(UIColor.HEX("#ff6b00"))
                .setOffset(width: 0, height: 0)
                .setOpacity(1)
                .setRadius(2)
                .setBringToFront()
                .setID("light")
                .apply()
        }
//        if !buttomDownload.isEnabled {
//
//            }
//        }else {
//            floatButton.removeShadowByID("light")
//        }
           
        buttom1.isEnabled = !buttom1.isEnabled
        buttomDownload.isEnabled = !buttomDownload.isEnabled
        
    }
    
    lazy var buttomNormal: Button = {
        let btn = Button()
            .setTitle("Normal", .normal)
            .setBorder({ build in
                build.setCornerRadius(12)
                    .setWidth(1)
            })
            .setConstraints { build in
                build.setBottom.equalToSafeArea(-201)
                    .setLeading.equalToSafeArea(20)
                    .setHeight.equalToConstant(50)
                    .setWidth.equalToConstant(250)
            }
            .setBackgroundColorLayer(.red)
        return btn
    }()
    
    lazy var buttomDownload: ButtonImage = {
        let btn = ButtonImage(UIImageView(image: UIImage(systemName: "arrow.down.to.line")))
            .setTitle("Download", .normal)
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
                    .setHeight.equalToConstant(45)
                    .setWidth.equalToConstant(180)
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
    
    
    lazy var floatButton: Button3D = {
        let img = UIImageView(image: UIImage(systemName: "rectangle.3.group"))

        
        let btn = Button3D(img)
//            .setImageSize(20)
            .setBorder({ build in
                build.setCornerRadius(19)
                    .setWidth(1)
//                    .setColor(.systemGray.withAlphaComponent(0.2))
                    .setColor(.white.withAlphaComponent(0.1))
            })
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#212326"),UIColor.HEX("#494d55")])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
            .setConstraints { build in
                build.setBottom.equalToSafeArea(-10)
                    .setTrailing.equalToSafeArea(-10)
                    .setHeight.setWidth.equalToConstant(60)
            }
            .addTarget(self, #selector(didTapFloatingButton), .touchUpInside)
            .setFloatButton()
        return btn
    }()
    
    
    lazy var menu: DropdownMenu = {
        let menu = DropdownMenu()
            .setBorder({ build in
                build.setCornerRadius(18)
                    .setWidth(0)
                    .setColor(.darkGray)
            })
        return menu
    }()
    
    lazy var subMenu: DropdownMenu = {
        let menu = DropdownMenu()
            .setBorder({ build in
                build.setCornerRadius(50)
                    .setWidth(0)
                    .setColor(.cyan)
            })
            .setConstraints { build in
                build.setTop.equalToSafeArea(100)
                    .setLeading.equalToSafeArea(100)
                    .setWidth.equalToConstant(200)
                    .setHeight.equalToConstant(200)
            }
        return menu
    }()
    
    
    
    private func addElements() {
        
        view.add(insideTo: self)
        view.applyConstraint()
        
        floatButton.add(insideTo: self)
        floatButton.applyConstraint()
        
        
        //
        //        buttomDownload.add(insideTo: self)
        //        buttomDownload.applyConstraint()
        //
        //
        //        buttom3D.add(insideTo: self)
        //        buttom3D.applyConstraint()
        //
        //        buttom1.add(insideTo: self)
        //        buttom1.applyConstraint()
        //
        //        buttomNormal.add(insideTo: self)
        //        buttomNormal.applyConstraint()
        //
        //        buttomLaranja.add(insideTo: self)
        //        buttomLaranja.applyConstraint()
        //
        //        botaozim.add(insideTo: self)
        //        botaozim.applyConstraint()
        
        
//        menu.add(insideTo: self)
//        menu.applyConstraint()
        
        subMenu.add(insideTo: self)
        subMenu.applyConstraint()
//
//        DispatchQueue.main.async {
//            self.menu.applyConstraints({ build in
//                build.setBottom.equalTo(self.floatButton, .top)
//                    .setTrailing.equalTo(self.floatButton, .trailing, -(self.floatButton.frame.width/3) )
//                    .setWidth.equalToConstant(170)
//                    .setHeight.equalToConstant(280)
//            })
//        }
        
            
        let originalColor = UIColor.HEX("#1d2021")
        let lightColor = originalColor.withBrightness()
        let darkColor = originalColor.withShadow()

        subMenu.setBackgroundColorLayer(UIColor.HEX("#1d2021"))
        menu.backgroundColor = UIColor.HEX("#0c0d0d")

        
        let distance = 12 // min:5 a max:50
        let blur = 12.0 // min:0 a max:50
        let intensity: Float = 0.66
        _ = subMenu
            .setShadow { build in
                build.setColor(darkColor)
                    .setOffset(width: distance, height: distance)
                    .setOpacity(intensity)
                    .setRadius(blur)
                    .apply()
            }
            .setShadow { build in
            build.setColor(lightColor)
                .setOffset(width: -distance, height: -distance)
                .setOpacity(intensity)
                .setRadius(blur)
                .apply()
        }
        
        print(lightColor.convertToHEX)
        print(darkColor.convertToHEX)
                
    }

}

extension UIColor {
    func withShadow() -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

        let newBrightness = brightness * 0.42
        return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
    }
    
    func withBrightness() -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        let newBrightness = brightness * 1.61
        return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
    }

}

