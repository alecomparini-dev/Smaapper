//
//  DropdownMenuFooter.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/05/23.
//

import UIKit

class DropdownMenuFooter: DropdownMenu {
    
    private var alreadyApplied = false
    private var _isShow = false
    
    private var footerHeight: CGFloat = 50
    private var footerGradient: Gradient?
    private var componentsFooter: [UIView] = []
    
    
//  MARK: - Initializers
    
    override init() {
        super.init()
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//  MARK: - Components
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 5
        return sv
    }()
    
    
//  MARK: - SET Properties
    func setFooterHeight(_ footerHeight: CGFloat) -> Self {
        self.footerHeight = footerHeight
        return self
    }
    
    func setFooterGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self {
        self.footerGradient = gradient(Gradient(stackView))
        return self
    }
    
    func setFooterComponent(_ componentView: UIView) -> Self {
        self.componentsFooter.append(componentView)
        return self
    }
    
    
    
//  MARK: - APPLY Dropdown Footer
    override var isShow: Bool {
        get { return _isShow }
        set {
            self._isShow = newValue
            applyOnceConfig()
            super.isShow = self._isShow
        }
    }

    
    
//  MARK: - Private Functions Area
    
    private func addComponentsOnFooter() {
        self.componentsFooter.forEach { component in
            let view = createView()
            component.add(insideTo: view)
            self.stackView.addArrangedSubview(view)
            view.applyConstraint()
            makeConstraint(component)
        }
    }
    
    private func createView() -> View {
        return View()
            .setConstraints { build in
                build.setTop
                    .setBottom.equalToSuperView
            }
    }
    
    
    private func makeConstraint(_ component: UIView) {
        component.makeConstraints { make in
            make.setTop.equalToSuperView(5)
                .setBottom.equalToSuperView
                .setLeading.setTrailing.equalToSuperView
        }
    }
    
    private func applyOnceConfig() {
        if self._isShow && !alreadyApplied {
            configDropdownMenuFooter()
            self.alreadyApplied = true
        }
    }
    
    private func addElements() {
        stackView.add(insideTo: self)
    }
    
    private func configDropdownMenuFooter() {
        configConstraint()
        configCornerRadius()
        configFooter()
        configGradient()
        addComponentsOnFooter()
        addShadowOnFooter()
    }
    
    private func addShadowOnFooter() {
        _ = stackView
            .setShadow({ build in
                build
                    .setColor(.black)
                    .setOffset(width: 0, height: -5)
                    .setBlur(5)
                    .setOpacity(0.8)
                    .setCornerRadius(0)
                    .setShadowHeight(10)
                    .apply()
            })
    }
    
    private func configConstraint() {
        stackView.makeConstraints { make in
            make
                .setBottom.setLeading.setTrailing.equalToSuperView
                .setHeight.equalToConstant(self.footerHeight)
        }
    }
    
    private func configFooter() {
        _ = self.setPaddingMenu(top: self.paddingMenu?.top ?? 0,
                                left: self.paddingMenu?.left ?? 0,
                                bottom: self.footerHeight,
                                right: self.paddingMenu?.right ?? 0)
    }

    private func configCornerRadius() {
        DispatchQueue.main.async {
            self.stackView.layer.cornerRadius = self.layer.cornerRadius
            _ = self.stackView.setBorder { build in
                build.setWhichCornersWillBeRounded([.bottom])
            }
        }
    }
    
    private func configGradient() {
        if let footerGradient = self.footerGradient {
            stackView.layoutIfNeeded()
            _ = footerGradient.apply(stackView)
        }
        
    }
    
    
}

