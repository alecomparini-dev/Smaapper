//
//  ListCellView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/05/23.
//

import UIKit

internal class ListCellView: ViewBuilder {

    private var leftViewCell: UIView?
    private var middleViewCell: UIView?
    private var rightViewCell: UIView?
    
    private var widthLeftColumnCell: CGFloat = 0
    private var widthRightColumnCell: CGFloat = 0
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//  TODO: - REFACTOR: REMOVE THIS FUNCTION, IT SHOULD BE IN LISTCELL
    
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
    
    @discardableResult
    func setBackgroundColorCell(_ color: UIColor) -> Self {
        self.view.backgroundColor = color
        return self
    }
                                                  
    
//  MARK: - Setup Cell
    func setupCell(_ leftView: UIView?, _ middleView: UIView?, _ rightView: UIView?) {
        self.leftViewCell = leftView
        self.middleViewCell = middleView
        self.rightViewCell = rightView
        removeSubViews(self.view)
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
        self.leftViewCell?.add(insideTo: self.view)
        self.leftViewCell?.makeConstraints { make in
            make
                .setTop
                .setBottom
                .setLeading.equalToSuperView
                .setWidth.equalToConstant(self.widthLeftColumnCell)
        }
    }
    
    private func addMiddleView() {
        if self.middleViewCell == nil {
            self.middleViewCell = UIView()
        }
        self.middleViewCell?.add(insideTo: self.view)
        self.middleViewCell?.makeConstraints { make in
            make
                .setTop.setBottom.equalToSuperView
                .setLeading.equalTo(self.leftViewCell!, .trailing)
                .setTrailing.equalTo(self.rightViewCell!, .leading)
        }
    }
    
    private func addRightView() {
        if self.rightViewCell == nil {
            self.rightViewCell = UIView()
            self.widthRightColumnCell = 0
        }
        
        self.rightViewCell?.add(insideTo: self.view)
        self.rightViewCell?.makeConstraints { make in
            make
                .setTop.equalToSafeArea
                .setBottom.equalToSafeArea
                .setTrailing.equalToSuperView
                .setWidth.equalToConstant(self.widthRightColumnCell)
        }
        

    }
    
    private func removeSubViews(_ view: UIView) {
        view.subviews.forEach { subView in
            subView.removeFromSuperview()
        }
    }
    
    
}


