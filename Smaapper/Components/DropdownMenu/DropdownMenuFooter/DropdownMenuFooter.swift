//
//  DropdownMenuFooter.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/05/23.
//

import UIKit

class DropdownMenuFooter: DropdownMenu {
    
    private var footerHeight: CGFloat = 50
    private var footerGradient: Gradient?
    private var componentsFooter: [UIView] = []
    
    
    private var alreadyApplied = false
    private var _isShow = false
    
    
//  MARK: - Initializers
    override init() {
        super.init()
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//  MARK: - Components
    lazy var stackView: Stack = {
        let sv = Stack()
            .setDistribution(.fillEqually)
            .setAxis(.horizontal)
            .setAlignment(.center)
            .setSpacing(5)
        return sv
    }()
    
    


//  MARK: - SET Properties
    @discardableResult
    func setFooterHeight(_ footerHeight: CGFloat) -> Self {
        self.footerHeight = footerHeight
        return self
    }

    @discardableResult
    func setFooterGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self {
        self.footerGradient = gradient(Gradient(stackView))
        return self
    }

    @discardableResult
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
            view.add(insideTo: stackView)
            view.applyConstraint()
            makeConstraintComponent(component)
        }
    }
    
    private func createView() -> View {
        return View()
            .setConstraints { build in
                build.setTop.setBottom.equalToSuperView
            }
    }
    
    
    private func makeConstraintComponent(_ component: UIView) {
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
        stackView
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
                .setPinBottom.equalToSuperView
                .setHeight.equalToConstant(self.footerHeight)
        }
    }
    
    private func configFooter() {
        self.setPaddingMenu(top: self.paddingMenu?.top ?? 0,
                                       left: self.paddingMenu?.left ?? 0,
                                       bottom: self.footerHeight,
                                       right: self.paddingMenu?.right ?? 0)
    }

    private func configCornerRadius() {
            self.stackView.layer.cornerRadius = self.layer.cornerRadius
            self.stackView.setBorder { build in
                build
                    .setWhichCornersWillBeRounded([.bottom])
            }
    }
    
    private func configGradient() {
        if let footerGradient = self.footerGradient {
            stackView.layoutIfNeeded()
            footerGradient.apply()
        }
        
    }
    
    
}

