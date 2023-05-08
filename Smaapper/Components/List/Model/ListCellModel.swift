//
//  ListCellModel.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/05/23.
//

import UIKit

class Section {
    let leftView: UIView?
    let middleView: UIView?
    let rightView: UIView?
    
    var rows = [Row]()
    
    init(leftView: UIView? = nil, middleView: UIView? = nil, rightView: UIView? = nil) {
        self.leftView = leftView
        self.middleView = middleView
        self.rightView = rightView
    }
    
    func setRow(leftView: UIView? = nil, middleView: UIView, rightView: UIView? = nil) -> Self {
        let row = Row(leftView: leftView, middleView: middleView, rightView: rightView)
        self.rows.append(row)
        return self
    }
    
}


class Row {
    let leftView: UIView?
    let middleView: UIView
    let rightView: UIView?
    
    init(leftView: UIView? = nil, middleView: UIView, rightView: UIView? = nil) {
        self.leftView = leftView
        self.middleView = middleView
        self.rightView = rightView
    }
}
