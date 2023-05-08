//
//  ListCellView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/05/23.
//

import UIKit

class ListCellView: View {
    
    var cont = 1
    private var data: Section?
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//  MARK: - Setup Cell
    func setupCell(_ leftView: UIView?, _ middleView: UIView?, _ rightView: UIView?) {
        addLeftView()
        addMiddleView()
        addRightView()
    }
  
    
//  MARK: - Private Functions Area
    
    private func addLeftView() {
        
    }
    
    private func addMiddleView() {
        
    }
    
    private func addRightView() {
        
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
