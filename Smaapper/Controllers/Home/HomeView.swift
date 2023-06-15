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
}

class HomeView: ViewBuilder {
    
    private weak var delegate: HomeViewDelegate?
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
    
    lazy var viewFloatWindow: ViewBuilder = {
        let view = ViewBuilder()
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return view
    }()
    
    
    //  MARK: - WEATHER
    lazy var weather: WeatherForecastView = {
        let view = WeatherForecastView(temperature: 25)
            .setBorder({ build in
                build
                    .setCornerRadius(35)
                    .setWhichCornersWillBeRounded([.right])
            })
            .setNeumorphism({ build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainer)
                    .setShape(.convex)
                    .setLightPosition(.leftTop)
                    .setBlur(percent: 10)
                    .setDistance(to: .light, percent: 1)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(35)
                    .setLeading.equalToSuperView
                    .setHeight.equalToConstant(70)
                    .setWidth.equalToConstant(115)
            }
        return view
    }()
    
    
    //  MARK: - CLOCK NEUMORPHISM
    
    lazy var clock: ClockNeumorphism = {
        let clock = ClockNeumorphism()
            .setWeight(4)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(45)
                    .setTrailing.equalToSafeArea(-20)
                    .setWidth.equalToConstant(120)
                    .setHeight.equalToConstant(40)
            }
        return clock
    }()
    
    
    //  MARK: - ASK CHAT GPT VIEW
    
    lazy var askChatGPTView: AskChatGPTView = {
        let view = AskChatGPTView()
            .setBorder({ build in
                build
                    .setCornerRadius(20)
            })
            .setGradient({ build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainer, percentageGradient: -20)
                    .setAxialGradient(.leftToRight)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(weather.view, .bottom, 40)
                    .setLeading.setTrailing.equalToSafeArea(20)
                    .setHeight.equalToConstant(168)
            }
        return view
    }()
    
    lazy var chatGPTTextField: TextFieldImageBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: "message.and.waveform.fill"))
        let tf = TextFieldImageBuilder(img.view)
        return tf
    }()
    
    
    //  MARK: - DROPDOW MENU
    
    lazy var dropdownMenu: DropdownMenuFooterBuilder = {
        return DropdownMenuFooterBuilder()
            .setFooterHeight(65)
            .setFooterGradient { build in
                build
                    .setGradientColors(Theme.shared.currentTheme.primaryGradient)
                    .setAxialGradient(.leftTopToRightBottom)
            }
            .setFooterComponent(settingsDropdownMenuFooterIconButton.view)
            .setFooterComponent(profileDropdownMenuFooterIconButton.view)
            .setFooterComponent(recentDropdownMenuFooterIconButton.view)
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
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainerLow)
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
            .setActions { build in
                build
                    .setAction(touch: dropdownMenuTapped)
                    .setAction(event: .openMenu, closure: openMenu)
                    .setAction(event: .closeMenu, closure: closeMenu)
            }
    }()
    
    lazy var profileDropdownMenuFooterIconButton: IconButtonBuilder = {
        return IconButtonBuilder(ImageViewBuilder(UIImage(systemName: "person")).view, "Profile")
            .setImageWeight(.medium)
            .setImageSize(18)
            .setTitleColor(Theme.shared.currentTheme.onPrimary, .normal)
            .setTitleSize(12)
            .setImageColor(Theme.shared.currentTheme.onPrimary)
    }()
    
    lazy var recentDropdownMenuFooterIconButton: IconButtonBuilder = {
        return IconButtonBuilder(ImageViewBuilder(UIImage(systemName: "rectangle.stack")).view)
            .setImageWeight(.medium)
            .setImageSize(18)
            .setTitleColor(Theme.shared.currentTheme.onPrimary, .normal)
            .setTitleSize(12)
            .setTitle("Recent", .normal)
            .setImageColor(Theme.shared.currentTheme.onPrimary)
    }()
    
    lazy var settingsDropdownMenuFooterIconButton: IconButtonBuilder = {
        return IconButtonBuilder(ImageViewBuilder(UIImage(systemName: "gearshape")).view, "Settings")
            .setImageWeight(.medium)
            .setImageSize(18)
            .setTitleColor(Theme.shared.currentTheme.onPrimary, .normal)
            .setTitleSize(12)
            .setImageColor(Theme.shared.currentTheme.onPrimary)
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
    
    
    //  MARK: - MENU FLOAT BUTTON
    
    lazy var menuButton: ButtonImageBuilder = {
        let img = UIImageView(image: UIImage(systemName: "rectangle.3.group"))
        return ButtonImageBuilder(img)
            .setFloatButton()
            .setImageColor(Theme.shared.currentTheme.onSurface)
            .setImageSize(16)
            .setBorder({ build in
                build.setCornerRadius(14)
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainerLowest)
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .setBlur(to: .light, percent: 5)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setBottom.equalToSafeArea(-10)
                    .setTrailing.equalToSafeArea(-15)
                    .setHeight.setWidth.equalToConstant(60)
            }
            .setActions { build in
                build
                    .setTarget(self, #selector(menuButtonTapped), .touchUpInside)
            }
            
    }()
    
    @objc
    private func menuButtonTapped() {
        delegate?.menuButtonTapped()
    }
    
    
    //  MARK: - DOCK
    
    lazy var dock: DockBuilder = {
        return DockBuilder( )
            .setSize(CGSize(width: 40 , height: 40))
            .setMinimumLineSpacing(12)
            .setBlur(true, 0.7)
            .setContentInset(top: 10, left: 10, bottom: 10, rigth: 10)
            .setBorder({ build in
                build
                    .setColor(Theme.shared.currentTheme.onSurfaceVariant.withAlphaComponent(0.2))
                    .setWidth(1)
                    .setCornerRadius(15)
            })
            .setConstraints { build in
                build
                    .setLeading.equalToSafeArea(20)
                    .setHeight.equalToConstant(60)
                    .setVerticalAlignmentY.equalTo(menuButton.view)
            }
            
    }()

    
    
//  MARK: - Public Functions Area
    func setDelegate(_ delegate: HomeViewDelegate) {
        self.delegate = delegate
    }
    
    func turnOnMenuButton() {
        menuButton.setShadow { build in
            build
                .setColor(Theme.shared.currentTheme.primary)
                .setOffset(width: 0, height: 0)
                .setOpacity(1)
                .setRadius(4)
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
            .setColor(Theme.shared.currentTheme.onSurfaceVariant)
            .setFont(UIFont.systemFont(ofSize: 17, weight: .semibold))
            .setTextAlignment(.left)
            .view
    }

    
//  MARK: - Create Rows Menu
    
    func createLeftRowView(_ systemNameImage: String) -> UIView {
        return ImageViewBuilder()
            .setImage(UIImage(systemName: systemNameImage))
            .setContentMode(.center)
            .setSize(18)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .view
    }
    
    func createMiddleRowView(_ text: String) -> UIView {
        return LabelBuilder(text)
            .setColor(Theme.shared.currentTheme.onSurface)
            .setFont(UIFont.systemFont(ofSize: 15, weight: .regular))
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
    
    func createIconsDock(_ systemNameImage: String) -> UIView {
        let img = ImageViewBuilder(UIImage(systemName: systemNameImage)).view
        let btn = IconButtonBuilder(img)
            .setImageColor(Theme.shared.currentTheme.onSurface)
            .setImageSize(14)
            .setBorder { make in
                make
                    .setCornerRadius(8)
                    .setWidth(0)
            }
            .setNeumorphism({ build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainer)
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .setBlur(to: .light, percent: 3)
                    .setBlur(to: .dark, percent: 5)
                    .setDistance(to: .light, percent: 3)
                    .setDistance(to: .dark, percent: 5)
                    .apply()
            })
        return btn.view
    }

    
    
//  MARK: - Private Function Area
    
    private func addElements() {
        clock.add(insideTo: self.view)
        viewFloatWindow.add(insideTo: self.view)
        weather.add(insideTo: self.view)
        askChatGPTView.add(insideTo: self.view)
        dropdownMenu.add(insideTo: self.view)
        dock.add(insideTo: self.view)
        menuButton.add(insideTo: self.view)
        
    }
    
    private func applyConstraints() {
        weather.applyConstraint()
        clock.applyConstraint()
        menuButton.applyConstraint()
        dropdownMenu.applyConstraint()
        dock.applyConstraint()
        askChatGPTView.applyConstraint()
        viewFloatWindow.applyConstraint()
    
    }
    
    
    private func addBackgroundColor() {
        self.setGradient { build in
            build
                .setGradientColors(Theme.shared.currentTheme.backgroundColorGradient)
                .setAxialGradient(.leftTopToRightBottom)
                .apply()
        }
    }
    
    
}
