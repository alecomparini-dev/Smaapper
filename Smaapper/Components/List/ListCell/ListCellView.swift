//
//  ListCellView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/05/23.
//

import UIKit

class ListCellView: View {

    private var leftViewCell: UIView?
    private var middleViewCell: UIView?
    private var rightViewCell: UIView?
    
    private var widthLeftColumnCell: CGFloat = 35
    private var widthRightColumnCell: CGFloat = 35
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//  MARK: - SET Properties
    @discardableResult
    internal func setWidthLeftColumnCell(_ width: CGFloat) -> Self {
        self.widthLeftColumnCell = width
        return self
    }
    
    @discardableResult
    internal func setWidthRightColumnCell(_ width:  CGFloat) -> Self {
        self.widthRightColumnCell = width
        return self
    }
                                                  
    
//  MARK: - Setup Cell
    func setupCell(_ leftView: UIView?, _ middleView: UIView?, _ rightView: UIView?) {
        self.leftViewCell = leftView
        self.middleViewCell = middleView
        self.rightViewCell = rightView
        removeSubViews(self)
        addLeftView()
        addRightView()
        addMiddleView()
    }
  
    
//  MARK: - Private Functions Area
    
    private func addLeftView() {
        if self.leftViewCell == nil {
            self.leftViewCell = UIView()
            self.widthLeftColumnCell = 0
        }
        self.leftViewCell?.add(insideTo: self)
        self.leftViewCell?.makeConstraints { make in
            make
                .setTop.setBottom.equalToSuperView
                .setLeading.equalToSuperView
                .setWidth.equalToConstant(self.widthLeftColumnCell)
        }
    }
    
    private func addMiddleView() {
        if self.middleViewCell == nil {
            self.middleViewCell = UIView()
        }
        self.middleViewCell?.add(insideTo: self)
        self.middleViewCell?.makeConstraints { make in
            make
                .setTop.setBottom.equalToSuperView
                .setLeading.equalTo(self.leftViewCell!, .trailing, 2)
                .setTrailing.equalTo(self.rightViewCell!, .leading, -2)
        }
    }
    
    private func addRightView() {
        if self.rightViewCell == nil {
            self.rightViewCell = UIView()
            self.widthRightColumnCell = 0
        }
        self.rightViewCell?.add(insideTo: self)
        self.rightViewCell?.makeConstraints { make in
            make
                .setTop.setBottom.setTrailing.equalToSuperView
                .setWidth.equalToConstant(self.widthRightColumnCell)
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


