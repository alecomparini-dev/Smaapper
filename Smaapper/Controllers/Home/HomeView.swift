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
    
    lazy var subMenu: DropdownMenu = {
        let menu = DropdownMenu()
            .setBorder({ build in
                build.setCornerRadius(40)
                    .setWidth(0)
                    .setColor(.cyan)
            })
            .setNeumorphism { build in
                build.setReferenceColor(UIColor.HEX("#17191a"))
                    .setIntensity(percent: 100)
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .apply()
            }
            .setConstraints { build in
                build.setTop.equalToSafeArea(80)
                    .setLeading.equalToSafeArea(100)
                    .setWidth.equalToConstant(200)
                    .setHeight.equalToConstant(200)
            }
        return menu
    }()
    
    lazy var dropdownMenu: DropdownMenu = {
        let menu = DropdownMenu()
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
                    .setShape(.flat)
                    .setLightPosition(.leftTop)
                    .setDistance(percent: 0)
                    .setBlur(percent: 10)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setBottom.equalTo(menuButton, .top, -15)
                    .setTrailing.equalTo(menuButton, .trailing, -5)
                    .setHeight.equalToConstant(300)
                    .setWidth.equalToConstant(240)
            }
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
    
    
    lazy var leftView: ImageView = {
        let img = ImageView()
            .setContentMode(.center)
            .setSize(18)
            .setTintColor(.white.withAlphaComponent(0.8))
        return img
    }()
    
    
    lazy var sectionView: Label = {
        let label = Label()
            .setColor(.white.withAlphaComponent(0.9))
            .setFont(UIFont.systemFont(ofSize: 15, weight: .regular))
            .setTextAlignment(.left)
        return label
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
                .setRadius(4)
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
            .setFont(UIFont.systemFont(ofSize: 15, weight: .regular))
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

