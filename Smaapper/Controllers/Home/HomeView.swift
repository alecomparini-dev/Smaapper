//
//  Home.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/04/23.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func menuButtonTapped()
    func dropdownMenuTapped(_ rowTapped:(section: Int, row: Int))
}

class HomeView: View {
    
    weak var delegate: HomeViewDelegate?
    
    private let idShadowEnableFloatButton = "shadowFloatButtonID"
    
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
            .setFooterHeight(65)
            .setPaddingMenu(top: 15, left: 15, bottom: 10, right: 15)
            .setPaddingColuns(left: 5, right: 5) // --> Ainda nao funciona
            .setNeumorphism { build in
                build
                    .setReferenceColor(UIColor.HEX("#17191a"))
                    .setShape(.concave)
                    .setLightPosition(.rightBottom)
                    .apply()
            }
            .setFooterGradient { build in
                build
                    .setColor([UIColor.HEX("#ff6b00"),UIColor.HEX("#ec9355")])
                    .setAxialGradient(.rightBottomToLeftTop)
            }
            .setFooterComponent(settingsButton)
            .setFooterComponent(profileButton)
            .setFooterComponent(recentButton)
            .setAction(dropdownMenuTapped)
            .setConstraints { build in
                build
                    .setTop.lessThanOrEqualToSuperView(15)
                    .setBottom.equalTo(menuButton, .top, -15)
                    .setTrailing.equalTo(menuButton, .trailing, -5)
                    .setHeight.equalToConstant(400)
                    .setWidth.equalToConstant(255)
            }
        return menu
    }()
    
    private func dropdownMenuTapped(_ rowTapped:(section: Int, row: Int)) {
        delegate?.dropdownMenuTapped(rowTapped)
    }
    
    lazy var menuButton: ButtonImage = {
        let img = UIImageView(image: UIImage(systemName: "rectangle.3.group"))
        let btn = ButtonImage(img)
            .setImageColor(.white)
            .setImageSize(14)
            .setBorder({ build in
                build.setCornerRadius(14)
                    .setWidth(0)
                    .setColor(.systemGray.withAlphaComponent(0.2))
                    .setColor(.white.withAlphaComponent(0.1))
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(UIColor.HEX("#17191a"))
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .apply()
            }
            .setConstraints { build in
                build.setBottom.equalToSafeArea(-10)
                    .setTrailing.equalToSafeArea(-20)
                    .setHeight.setWidth.equalToConstant(50)
            }
            .setTarget(self, #selector(menuButtonTapped), .touchUpInside)
            .setFloatButton()
        return btn
    }()
    
    lazy var profileButton: IconButton = {
        let btn = IconButton(ImageView(UIImage(systemName: "person")), "Profile")
            .setImageWeight(.medium)
            .setImageSize(18)
            .setTitleColor(UIColor.HEX("#0f1010"), .normal)
            .setTitleSize(12)
            .setImageColor(UIColor.HEX("#0f1010"))
        return btn
    }()
    

    lazy var recentButton: IconButton = {
        let btn = IconButton(ImageView(UIImage(systemName: "rectangle.stack")))
            .setImageWeight(.medium)
            .setImageSize(18)
            .setTitleColor(UIColor.HEX("#0f1010"), .normal)
            .setTitleSize(12)
            .setTitle("Recent", .normal)
            .setImageColor(UIColor.HEX("#0f1010"))
        return btn
    }()
    
    
    lazy var settingsButton: IconButton = {
        let btn = IconButton(ImageView(UIImage(systemName: "gearshape")), "Settings")
            .setImageWeight(.medium)
            .setImageSize(18)
            .setTitleColor(UIColor.HEX("#0f1010"), .normal)
            .setTitleSize(12)
            .setImageColor(UIColor.HEX("#0f1010"))
        return btn
    }()
    
    
    lazy var dock: Dock = {
        let dock = Dock()
            .setBorder({ build in
                build.setColor(.darkGray)
                    .setWidth(1)
                    .setCornerRadius(10)
            })
            .setConstraints { build in
                build
                    .setLeading.equalToSafeArea(15)
                    .setTop.setBottom.equalTo(menuButton)
                    .setTrailing.equalTo(menuButton, .leading, -10)
            }
        return dock
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

    
//  MARK: - Create Section Menu
    func createMiddleSectionView(_ text: String) -> UIView {
        let label = Label(text)
            .setColor(UIColor.systemGray)
            .setFont(UIFont.systemFont(ofSize: 16, weight: .semibold))
            .setTextAlignment(.left)
        return label
    }

    
//  MARK: - Create Rows Menu
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
            .setFont(UIFont.systemFont(ofSize: 14, weight: .regular))
            .setTextAlignment(.left)
        return label
    }
    
    func createRightRowView(_ systemNameImage: String, _ color: UIColor) -> UIView {
        let img = ImageView()
            .setImage(UIImage(systemName: systemNameImage))
            .setContentMode(.center)
            .setSize(14)
            .setWeight(.regular)
            .setTintColor(color)
        return img
    }

    
    
//  MARK: - Private Function Area

    private func addBackgroundColor() {
        _ = self.makeGradient { build in
            build
                .setColor([UIColor.HEX("#17191a").getBrightness(1.7),  UIColor.HEX("#17191a").getBrightness(0.7)])
                .setAxialGradient(.leftTopToRightBottom)
                .apply()
        }
    }
    
    private func addElements() {
        menuButton.add(insideTo: self)
        dropdownMenu.add(insideTo: self)
        dock.add(insideTo: self)
    }
    
    private func applyConstraints() {
        menuButton.applyConstraint()
        dropdownMenu.applyConstraint()
        dock.applyConstraint()
        dock.isShow = true
        
        
    }
    
}
