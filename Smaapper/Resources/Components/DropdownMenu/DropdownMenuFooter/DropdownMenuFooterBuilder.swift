//
//  DropdownMenuFooterBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

class DropdownMenuFooterBuilder: DropdownMenuBuilder {
    
    private var alreadyApplied = false
    private var _isShow = false
    
    private var _dropdownFooter: DropdownMenuFooter
    var dropdownFooter: DropdownMenuFooter { self._dropdownFooter }

    override init() {
        self._dropdownFooter = DropdownMenuFooter()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - SET Properties
    @discardableResult
    func setFooterHeight(_ footerHeight: CGFloat) -> Self {
        _dropdownFooter.footerHeight = footerHeight
        return self
    }

    @discardableResult
    func setFooterGradient(_ gradient: (_ build: GradientBuilder) -> GradientBuilder) -> Self {
        _dropdownFooter.footerGradient = gradient(GradientBuilder(_dropdownFooter.stackView.view))
        return self
    }

    @discardableResult
    func setFooterComponent(_ componentView: UIView) -> Self {
        _dropdownFooter.componentsFooter.append(componentView)
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
        _dropdownFooter.componentsFooter.forEach { component in
            let view = createView()
            component.add(insideTo: view.view)
            view.add(insideTo: _dropdownFooter.stackView.view)
            view.applyConstraint()
            makeConstraintComponent(component)
        }
    }
    
    private func createView() -> ViewBuilder {
        return ViewBuilder()
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
    
    private func addElements(){
        _dropdownFooter.stackView.add(insideTo: super.dropdown)
    }
    
    private func configDropdownMenuFooter() {
        addElements()
        configConstraint()
        configCornerRadius()
        configFooter()
        configGradient()
        addComponentsOnFooter()
        addShadowOnFooter()
    }
    
    
    private func addShadowOnFooter() {
        _dropdownFooter.stackView
            .setShadow({ build in
                build
                    .setColor(.black)
                    .setOffset(width: 0, height: -5)
                    .setRadius(5)
                    .setOpacity(0.8)
                    .setCornerRadius(0)
                    .setShadowHeight(10)
                    .apply()
            })
        
    }
    
    private func configConstraint() {
        _dropdownFooter.stackView.setConstraints({ build in
            build
                .setPinBottom.equalToSuperView
                .setHeight.equalToConstant(self._dropdownFooter.footerHeight)
                .apply()
        })
    }
    
    private func configFooter() {
        self.setPaddingMenu(top: super.dropdown.paddingMenu?.top ?? 0,
                            left: super.dropdown.paddingMenu?.left ?? 0,
                            bottom: self._dropdownFooter.footerHeight,
                            right: super.dropdown.paddingMenu?.right ?? 0)
    }

    
    private func configCornerRadius() {
        self._dropdownFooter.stackView.view.layer.cornerRadius = super.dropdown.layer.cornerRadius
        self._dropdownFooter.stackView.setBorder { build in
                build
                    .setWhichCornersWillBeRounded([.bottom])
            }
    }
    
    private func configGradient() {
        if let footerGradient = self._dropdownFooter.footerGradient {
            _dropdownFooter.stackView.view.layoutIfNeeded()
            footerGradient.apply()
        }
        
    }
    
    
    
}
