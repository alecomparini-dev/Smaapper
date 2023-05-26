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
    func openMenu()
    func closeMenu()
    func numberOfItemsCallback() -> Int
    func dockCellCalback(_ indexCell: Int) -> UIView
}

class HomeView: View {
    
    weak var delegate: HomeViewDelegate?
    
    private let idShadowEnableFloatButton = "shadowFloatButtonID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        addBackgroundColor()
        addElements()
        applyConstraints()
    }
    
//  MARK: - LAZY Properties
    
    lazy var clock: ClockNeumorphism = {
        let clock = ClockNeumorphism()
            .setWeight(4)
            .setConstraints { build in
                build
                    .setTop.setTrailing.equalToSafeArea(30)
                    .setWidth.equalToConstant(110)
                    .setHeight.equalToConstant(40)
            }
        return clock
    }()
    
        
    lazy var dropdownMenu: DropdownMenuFooterBuilder = {
        let drop = DropdownMenuFooterBuilder()
            .setFooterHeight(65)
            .setFooterGradient { build in
                build
                    .setColor([UIColor.HEX("#ff6b00"),UIColor.HEX("#ec9355")])
                    .setAxialGradient(.rightBottomToLeftTop)
            }
            .setFooterComponent(settingsButton.view)
            .setFooterComponent(profileButton.view)
            .setFooterComponent(recentButton.view)
            .setAutoCloseMenuWhenTappedOut(excludeComponents: [menuButton.view])
            .setRowHeight(45)
            .setPaddingMenu(top: 15, left: 15, bottom: 10, right: 15)
            .setPaddingColuns(left: 5, right: 5) // --> Ainda nao funciona
            .setBorder({ build in
                build
                    .setCornerRadius(18)
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(UIColor.HEX("#17191a"))
                    .setShape(.concave)
                    .setLightPosition(.rightBottom)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setBottom.equalTo(menuButton.view, .top, -15)
                    .setTrailing.equalTo(menuButton.view, .trailing, -5)
                    .setHeight.equalToConstant(400)
                    .setWidth.equalToConstant(255)
            }
            

        
        drop.actions
            .setAction(touch: dropdownMenuTapped)
            .setAction(event: .openMenu, closure: openMenu)
            .setAction(event: .closeMenu, closure: closeMenu)
        return drop
    }()
    
    private func dropdownMenuTapped(_ rowTapped:(section: Int, row: Int)) {
        delegate?.dropdownMenuTapped(rowTapped)
    }
    private func openMenu() {
        delegate?.openMenu()
    }
    private func closeMenu() {
        delegate?.closeMenu()
    }

    lazy var menuButton: ButtonImageBuilder = {
        let img = UIImageView(image: UIImage(systemName: "rectangle.3.group"))
        let btn = ButtonImageBuilder(img)
            .setImageColor(.white)
            .setImageSize(14)
            .setBorder({ build in
                build.setCornerRadius(14)
                    .setWidth(0)
                    .setColor(.systemGray.withAlphaComponent(0.2))
                    .setColor(.white.withAlphaComponent(0.1))
            })
            .setFloatButton()
            .setConstraints { build in
                build
                    .setBottom.equalToSafeArea(-10)
                    .setTrailing.equalToSafeArea(-15)
                    .setHeight.setWidth.equalToConstant(60)
            }
            .setNeumorphism { build in
                build
                    .setReferenceColor(UIColor.HEX("#17191a"))
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .apply()
            }
        btn.actions?
            .setTarget(self, #selector(menuButtonTapped), .touchUpInside)
        return btn
    }()
    
    lazy var profileButton: IconButtonBuilder = {
        return IconButtonBuilder(ImageViewBuilder(UIImage(systemName: "person")).view, "Profile")
            .setImageWeight(.medium)
            .setImageSize(18)
            .setTitleColor(UIColor.HEX("#0f1010"), .normal)
            .setTitleSize(12)
            .setImageColor(UIColor.HEX("#0f1010"))
    }()
    
    lazy var recentButton: IconButtonBuilder = {
        return IconButtonBuilder(ImageViewBuilder(UIImage(systemName: "rectangle.stack")).view)
            .setImageWeight(.medium)
            .setImageSize(18)
            .setTitleColor(UIColor.HEX("#0f1010"), .normal)
            .setTitleSize(12)
            .setTitle("Recent", .normal)
            .setImageColor(UIColor.HEX("#0f1010"))
    }()
    
    lazy var settingsButton: IconButtonBuilder = {
        return IconButtonBuilder(ImageViewBuilder(UIImage(systemName: "gearshape")).view, "Settings")
            .setImageWeight(.medium)
            .setImageSize(18)
            .setTitleColor(UIColor.HEX("#0f1010"), .normal)
            .setTitleSize(12)
            .setImageColor(UIColor.HEX("#0f1010"))
    }()
    
    lazy var dock: DockBuilder = {
        let dock = DockBuilder(numberOfItemsCallback: numberOfItemsCallback, cellCallback: dockCellCalback)
            .setSize(CGSize(width: 40 , height: 40))
            .setMinimumLineSpacing(12)
            .setBlur(true, 0.7)
            .setContentInset(top: 8, left: 10, bottom: 10, rigth: 10)
            .setBorder({ build in
                build
                    .setColor(.white.withAlphaComponent(0.1))
                    .setWidth(1)
                    .setCornerRadius(15)
            })
            .setConstraints { build in
                build
                    .setLeading.equalToSafeArea(20)
                    .setHeight.equalToConstant(60)
                    .setVerticalAlignmentY.equalTo(menuButton.view)
            }
        return dock
    }()
    
    private func numberOfItemsCallback() -> Int {
        return delegate?.numberOfItemsCallback() ?? 0
    }
    
    private func dockCellCalback(_ indexCell: Int) -> UIView {
        return delegate?.dockCellCalback(indexCell) ?? UIView()
    }
    
    func dockIsShow(_ flag: Bool) {
        dock.isShow = flag
    }
    
    
    lazy var floatWindow: FloatWindow = {
        let win = FloatWindow(frame: CGRect(x: 140, y: 155, width: 210, height: 280))
            .setGradient({ build in
                build
                    .setColor([UIColor.HEX("#3d4248"), UIColor.HEX("#2a2e34")])
                    .setAxialGradient(.topToBottom)
                    .apply()
            })
            .setBorder { build in
                build
                    .setCornerRadius(24)
            }
            .setShadow { build in
                build
                    .setOpacity(1)
                    .setColor(.black)
                    .setCornerRadius(12)
                    .setBlur(25)
                    .setOffset(width: 5, height: 10)
                    .apply()
            }
            .setTitleWindow { build in
                build
                    .setTitleView(createTitleView())
            }
        return win
    }()
    
    
    private func createTitleView() -> UIView {
        let view = UIView()
        let closeWin = createCloseWindowButton()
        let dragDropView = createDragDropView()
        addElementsInTitleView(view, [closeWin.view,dragDropView])
        configButtonsConstraintsInTitleView(closeWin)
        return view
    }
    

    private func createCloseWindowButton() -> ButtonBuilder {
        let btn = ButtonBuilder()
            .setGradient({ build in
                build
                    .setColor([UIColor.HEX("#d32739"), UIColor.HEX("#d32739")])
                    .apply()
            })

            .setShadow({ build in
                build
                    .setColor(.black)
                    .setBlur(5)
                    .setOpacity(0.6)
                    .setOffset(width: 5, height: 5)
                    .apply()
            })
            .setBorder { build in
                build
                    .setCornerRadius(8)
            }
            .setConstraints { build in
                build
                    .setSize.equalToConstant(16)
            }
        return btn
    }
    
    private func createDragDropView() -> UIView {
        let view = View()
        
        return view
    }
    
    
    private func addElementsInTitleView(_ view: UIView, _ elements: [UIView]) {
        elements.forEach { elem in
            elem.add(insideTo: view)
        }
    }
    
    private func configButtonsConstraintsInTitleView( _ closeWin: ButtonBuilder) {
        closeWin.setConstraints { make in
            make
                .setTrailing.equalToSuperView(-12)
                .setVerticalAlignmentY.equalToSuperView(5)
        }
        closeWin.applyConstraint()
    }
    
    
    
    
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
        menuButton.view.removeShadowByID(idShadowEnableFloatButton)
    }

    
//  MARK: - Create Section Menu
    
    func createMiddleSectionView(_ text: String) -> UIView {
        return LabelBuilder(text)
            .setColor(UIColor.systemGray)
            .setFont(UIFont.systemFont(ofSize: 16, weight: .semibold))
            .setTextAlignment(.left)
            .view
    }

    
//  MARK: - Create Rows Menu
    
    func createLeftRowView(_ systemNameImage: String) -> UIView {
        return ImageViewBuilder()
            .setImage(UIImage(systemName: systemNameImage))
            .setContentMode(.center)
            .setSize(18)
            .setTintColor(.white.withAlphaComponent(0.8))
            .view
    }
    
    func createMiddleRowView(_ text: String) -> UIView {
        return LabelBuilder(text)
            .setColor(.white.withAlphaComponent(0.9))
            .setFont(UIFont.systemFont(ofSize: 14, weight: .regular))
            .setTextAlignment(.left)
            .view
    }
    
    func createRightRowView(_ systemNameImage: String, _ color: UIColor) -> UIView {
        return ImageViewBuilder()
            .setImage(UIImage(systemName: systemNameImage))
            .setContentMode(.center)
            .setSize(14)
            .setWeight(.regular)
            .setTintColor(color)
            .view
    }
    
    
//  MARK: - Private Function Area

    private func addBackgroundColor() {
        self.makeGradient { build in
            build
                .setColor([UIColor.HEX("#17191a").getBrightness(1.7),  UIColor.HEX("#17191a").getBrightness(0.7)])
                .setAxialGradient(.leftTopToRightBottom)
                .apply()
        }
    }
    
    private func addElements() {
        dropdownMenu.add(insideTo: self)
        dock.add(insideTo: self)
        menuButton.add(insideTo: self)
        self.clock.add(insideTo: self)
    }
    
    private func applyConstraints() {
        menuButton.applyConstraint()
        dropdownMenu.applyConstraint()
        dock.applyConstraint()
        self.clock.applyConstraint()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.floatWindow.add(insideTo: self)
//            self.floatWindow.applyConstraint()
//            self.floatWindow.isShow = true
//        }
        
        
        
    }
    
    func createIconsDock(_ systemNameImage: String) -> UIView {
        let img = ImageViewBuilder(UIImage(systemName: systemNameImage)).view
        let btn = IconButtonBuilder(img)
            .setImageColor(.white)
            .setImageSize(14)
            .setBorder { make in
                make
                    .setCornerRadius(8)
                    .setWidth(0)
            }
            .setNeumorphism({ build in
                build
                    .setReferenceColor(UIColor.HEX("#26292a"))
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 10)
                    .setIntensity(to: .dark, percent: 100)
                    .setBlur(to: .light, percent: 3)
                    .setBlur(to: .dark, percent: 5)
                    .setDistance(to: .light, percent: 3)
                    .setDistance(to: .dark, percent: 5)
                    .apply()
            })
        return btn.view
    }

    
    func showImage() {
        let img = ImageViewBuilder()
            .setImage(UIImage(named: "teste"))
            .setContentMode(.scaleAspectFill)
            .view
        
        img.add(insideTo: self)
        img.makeConstraints { make in
            make.setPin.equalToSuperView
        }

    }
    
    
}

