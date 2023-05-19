//
//  TitleWindow.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 19/05/23.
//

import UIKit


internal class TitleWindow: View {
    
    override init() {
        super.init()
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        addElements()
        configConstraint()
    }
    
    
//  MARK: - Lazy Properties
    lazy var leftView: View = {
        let view = View()
            .setConstraints { build in
                build.setPinLeft.equalToSuperView
            }
        return view
    }()
    
    lazy var middleView: View = {
        let view = View()
            .setConstraints { build in
                build
                    .setTop.setBottom.equalToSuperView
                    .setLeading.equalTo(leftView, .trailing)
                    .setTrailing.equalTo(rightView, .leading)
            }
        return view
    }()
    
    lazy var rightView: View = {
        let view = View()
            .setConstraints { build in
                build.setPinRight.equalToSuperView
            }
        return view
    }()
    
    
    
//  MARK: - SET Properties
    @discardableResult
    func setLeftView(_ view: UIView, _ size: CGFloat) -> Self {
        configWidthConstraintLeftView(size)
        addViewToLeftView(view)
        return self
    }
    
    @discardableResult
    func setMiddleView(_ view: UIView) -> Self {
        addViewToMiddleView(view)
        return self
    }
    
    @discardableResult
    func setRightView(_ view: UIView, _ size: CGFloat) -> Self {
        configWidthConstraintRightView(size)
        addViewToRightView(view)
        return self
    }
    
    
//  MARK: - Private Function Area
    
    private func addElements() {
        leftView.add(insideTo: self)
        middleView.add(insideTo: self)
        rightView.add(insideTo: self)
    }
    
    private func configConstraint() {
        leftView.applyConstraint()
        middleView.applyConstraint()
        rightView.applyConstraint()
    }
    
    
    private func configWidthConstraintLeftView(_ size: CGFloat) {
        leftView.makeConstraints { make in
            make.setWidth.equalToConstant(size)
        }
    }
    
    private func addViewToLeftView(_ view: UIView) {
        view.add(insideTo: leftView)
        view.makeConstraints { make in
            make.setPin.equalToSuperView
        }
    }
    
    private func addViewToMiddleView(_ view: UIView) {
        view.add(insideTo: middleView)
        view.makeConstraints { make in
            make.setPin.equalToSuperView
        }
    }
    
    private func configWidthConstraintRightView(_ size: CGFloat) {
        rightView.makeConstraints { make in
            make.setWidth.equalToConstant(size)
        }
    }
    
    private func addViewToRightView(_ view: UIView) {
        view.add(insideTo: rightView)
        view.makeConstraints { make in
            make.setPin.equalToSuperView
        }
    }
    
}
