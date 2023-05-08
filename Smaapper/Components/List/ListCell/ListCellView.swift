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
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        var width: CGFloat = 35
        if self.leftViewCell == nil {
            self.leftViewCell = UIView()
            width = 0
        }
        self.leftViewCell?.add(insideTo: self)
        self.leftViewCell?.makeConstraints { make in
            make
                .setTop.setBottom.equalToSuperView
                .setLeading.equalToSuperView
                .setWidth.equalToConstant(width)
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
                .setLeading.equalTo(self.leftViewCell!,.trailing, 2)
                .setTrailing.equalTo(self.rightViewCell!, .leading, -2)
        }
    }
    
    private func addRightView() {
        var width: CGFloat = 25
        if self.rightViewCell == nil {
            self.rightViewCell = UIView()
            width = 0
        }
        self.rightViewCell?.add(insideTo: self)
        self.rightViewCell?.makeConstraints { make in
            make
                .setTop.setBottom.setTrailing.equalToSuperView
                .setWidth.equalToConstant(width)
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


//private func configLeftViewConstraint() {
//    leftView.makeConstraints { make in
//        make.setTop.setBottom.equalToSuperView
//            .setLeading.equalToSuperView(30)
//    }
//
//    if self.data?.leftView == nil {
//        leftView.makeConstraints { make in
//            make.setWidth.equalToConstant(0)
//        }
//    }
//}
//
//private func configMiddleViewConstraint() {
//    middleView.makeConstraints { make in
//        make.setTop.setBottom.equalToSuperView
//            .setLeading.equalTo(leftView,.trailing, 2)
//            .setTrailing.equalTo(rightView,.leading, -2)
//    }
//}
//
//private func configRightViewConstraint() {
//    rightView.makeConstraints { make in
//        make.setTop.setBottom.setTrailing.equalToSuperView
//            .setWidth.equalToConstant(30)
//    }
//}
