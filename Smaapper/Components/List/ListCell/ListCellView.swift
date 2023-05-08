//
//  ListCellView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/05/23.
//

import UIKit

class ListCellView: View {
    
    var cont = 1
    private var data: ListCellModel?
    
    override init() {
        super.init()
        addElements()
        configConstraints()
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
        self.data = data
        addLeftView()
        addMiddleView()
        addRightViewToStackView()
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
                .setLeading.equalToSuperView(30)
        }
        
        if self.data?.leftView == nil {
            leftView.makeConstraints { make in
                make.setWidth.equalToConstant(0)
            }
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
            make.setTop.setBottom.setTrailing.equalToSuperView
                .setWidth.equalToConstant(30)
        }
    }
    
//  MARK: - Add Component
    
    private func addLeftView() {
        removeSubViews(self.leftView)
        if let componentView = data?.leftView {
            self.leftView.addSubview(componentView)
            pinConstraint(componentView)
        }
    }
    
    private func addRightViewToStackView() {
        removeSubViews(self.rightView)
        if let componentView = data?.rightView {
            self.rightView.addSubview(componentView)
            pinConstraint(componentView)
        }
    }
    
    private func addMiddleView() {
        if let middleView = data?.middleView {
            removeSubViews(self.middleView)
            self.middleView.addSubview(middleView)
            pinConstraint(middleView)
        }
        
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
