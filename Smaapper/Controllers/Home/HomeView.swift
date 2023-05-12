//
//  Home.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/04/23.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func menuButtonTapped()
}

class HomeView: UIView {
    
    private let idShadowEnableFloatButton = "shadowFloatButtonID"
    
    var delegate: HomeViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBackgroundColor()
        addElements()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var dropdownMenu: DropdownMenuFooter = {
        let menu = DropdownMenuFooter()
            .setBorder({ build in
                build
                    .setCornerRadius(18)
            })
            .setRowHeight(45)
            .setPaddingMenu(top: 15, left: 15, bottom: 10, right: 15)
            .setPaddingColuns(left: 5, right: 5)
            .setNeumorphism { build in
                build
                    .setReferenceColor(UIColor.HEX("#17191a"))
                    .setShape(.concave)
                    .setLightPosition(.rightBottom)
                    .setDistance(percent: 0)
                    .setBlur(percent: 10)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setBottom.equalTo(menuButton, .top, -15)
                    .setTrailing.equalTo(menuButton, .trailing, -5)
                    .setHeight.equalToConstant(400)
                    .setWidth.equalToConstant(255)
            }
            .setFooterHeight(65)
            .setFooterGradient { build in
                build
                    .setColor([UIColor.HEX("#ff6b00"),UIColor.HEX("#ec9355")])
                    .setAxialGradient(.rightBottomToLeftTop)
            }
            .setComponentView(configButton)
            .setComponentView(configButton2)
            .setComponentView(configButton3)
        return menu
    }()
    
    lazy var menuButton: ButtonImage = {
        let img = UIImageView(image: UIImage(systemName: "rectangle.3.group"))
        let btn = ButtonImage(img)
            .setBorder({ build in
                build.setCornerRadius(18)
                    .setWidth(0)
                    .setColor(.systemGray.withAlphaComponent(0.2))
                    .setColor(.white.withAlphaComponent(0.1))
            })
            .setNeumorphism { build in
                build
                    .setShape(.concave)
                    .setReferenceColor(UIColor.HEX("#17191a"))
                    .apply()
            }
            .setConstraints { build in
                build.setBottom.equalToSafeArea(-10)
                    .setTrailing.equalToSafeArea(-20)
                    .setHeight.setWidth.equalToConstant(60)
            }
            .addTarget(self, #selector(menuButtonTapped), .touchUpInside)
            .setFloatButton()
        return btn
    }()
    
    lazy var configButton: ButtonImage = {
        let btn = ButtonImage(ImageView(UIImage(systemName: "person")))
            .setImageWeight(.medium)
            .setImageSize(16)
            .setTitleColor(UIColor.HEX("#131415"), .normal)
        return btn
    }()
    
    lazy var configButton2: ButtonImage = {
        let btn = ButtonImage(ImageView(UIImage(systemName: "trash")))
            .setImageSize(12)
            .setImageWeight(.bold)
            .setTitleColor(UIColor.HEX("#131415"), .normal)
        return btn
    }()
    
    lazy var configButton3: ButtonImage = {
        let btn = ButtonImage(ImageView(UIImage(systemName: "gearshape")))
            .setImageWeight(.bold)
            .setImageSize(15)
            .setTitleColor(UIColor.HEX("#131415"), .normal)
        return btn
    }()
    
    
//  MARK: - Objc Functions Area
    
    @objc func menuButtonTapped() {
        delegate?.menuButtonTapped()
    }

    
//  MARK: - Public Functions Area
    func turnOnMenuButton() {
        _ = menuButton.setShadow { build in
            build.setColor(UIColor.HEX("#ff710b"))
                .setOffset(width: 0, height: 0)
                .setOpacity(1)
                .setBlur(4)
                .setBringToFront()
                .setID(idShadowEnableFloatButton)
                .apply()
        }
    }
    
    func turnOffMenuButton() {
        menuButton.removeShadowByID(idShadowEnableFloatButton)
    }

    func createLeftRowView(_ systemNameImage: String) -> UIView {
        let img = ImageView()
            .setImage(UIImage(systemName: systemNameImage))
            .setContentMode(.center)
            .setSize(18)
            .setTintColor(.white.withAlphaComponent(0.8))
        return img
    }
    
    func createMiddleRowView(_ text: String) -> UIView {
        let label = Label(text)
            .setColor(.white.withAlphaComponent(0.9))
            .setFont(UIFont.systemFont(ofSize: 15, weight: .light))
            .setTextAlignment(.left)
        return label
    }
    
    func createMiddleSectionView(_ text: String) -> UIView {
        let label = Label(text)
            .setColor(UIColor.systemGray)
            .setFont(UIFont.systemFont(ofSize: 16, weight: .semibold))
            .setTextAlignment(.left)
        return label
    }

    func createRightRowView(_ systemNameImage: String) -> UIView {
        let img = ImageView()
            .setImage(UIImage(systemName: systemNameImage))
            .setContentMode(.center)
            .setSize(14)
            .setWeight(.regular)
            .setTintColor(.white.withAlphaComponent(0.4))
        return img
    }
    
    
//  MARK: - Private Function Area

    private func addBackgroundColor() {
        _ = self.setGradient { build in
            build
                .setColor([UIColor.HEX("#17191a"), UIColor.HEX("#17191a"),  UIColor.HEX("#17191a")])
                .setAxialGradient(.leftTopToRightBottom)
                .apply()
        }
    }
    
    private func addElements() {
        menuButton.add(insideTo: self)
        dropdownMenu.add(insideTo: self)
    }
    
    private func applyConstraints() {
        menuButton.applyConstraint()
        dropdownMenu.applyConstraint()
    }
    

}

