//
//  ListCellView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/05/23.
//

import UIKit

class ListCellView: View {
    
    var cont = 1
    
    override init() {
        super.init()
        addElements()
        configConstraints()
        
        _ = self.setBorder { build in
            build.setColor(UIColor.HEX("#06312a"))
                .setWidth(0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var leftView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var middleView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var rightView: UIView = {
        let view = UIView()
        return view
    }()
    
//  MARK: - Setup Cell
    func setupCell(_ data: ListCellModel) {
        addLeftView(data.leftView)
        addTextToStackView(data.middleView)
        addRightViewToStackView(data.rightView)
    }
  
    
//  MARK: - Private Area
    private func addElements() {
        leftView.add(insideTo: self)
        middleView.add(insideTo: self)
        rightView.add(insideTo: self)
    }

//  MARK: - Config Constraints


    private func configConstraints() {
        configLeftViewConstraint()
        configMiddleViewConstraint()
        configRightViewConstraint()
    }
    
    private func configLeftViewConstraint() {
        leftView.makeConstraints { make in
            make.setTop.setBottom.equalToSuperView
                .setLeading.equalToSuperView
                .setWidth.equalToConstant(30)
        }
    }
    
    private func configMiddleViewConstraint() {
        middleView.makeConstraints { make in
            make.setTop.setBottom.equalToSuperView
                .setLeading.equalTo(leftView,.trailing, 2)
                .setTrailing.equalTo(rightView,.leading, -2)
        }
    }
    
    private func configRightViewConstraint() {
        rightView.makeConstraints { make in
            make.setTop.setBottom.equalToSuperView
                .setTrailing.equalToSuperView
                .setWidth.equalToConstant(15)
        }
    }
    
//  MARK: - Add Component
    
    private func addLeftView(_ componentView: UIView?) {
        if let componentView {
            removeSubViews(self.leftView)
            self.leftView.addSubview(componentView)
            pinConstraint(componentView)
        }
    }
    
    private func addRightViewToStackView(_ componentView: UIView?) {
        if let componentView {
            removeSubViews(self.rightView)
            self.rightView.addSubview(componentView)
            pinConstraint(componentView)
        }
    }
    
    
    private func addTextToStackView(_ text: UIView) {
        cont += 1
        _ = (text as! Label).setText("\((text as! Label).text ?? "") - \(cont)")
        removeSubViews(middleView)
        middleView.addSubview(text)
        pinConstraint(text)
    }

    private func removeSubViews(_ view: UIView) {
        view.subviews.forEach { subView in
            subView.removeFromSuperview()
        }
    }
    
    private func pinConstraint(_ view: UIView) {
        view.makeConstraints { make in
            make.setTop.setWidth.setLeading.setBottom.equalToSuperView
        }
    }
    
    
}
