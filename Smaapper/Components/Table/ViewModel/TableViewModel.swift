//
//  TableViewModel.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 03/04/23.
//

import UIKit

class TableViewModel {

    private var model = TableModel()
    
    var separatorStyle: UITableViewCell.SeparatorStyle? {
        get { model.separatorStyle }
        set { model.separatorStyle = newValue }
    }
    
    var showsScroll: ShowsScroll? {
        get { model.showsScroll }
        set { model.showsScroll = newValue }
    }
    
    var isScrollEnabled: Bool? {
        get { model.isScrollEnabled }
        set { model.isScrollEnabled = newValue }
    }
    
    var transform: CGAffineTransform? {
        get { model.transform }
        set { model.transform = newValue }
    }
    
    var tableFooter: UIView? {
        get { model.tableFooter }
        set { model.tableFooter = newValue }
    }
    
    var registerCell: [AnyClass] {
        get { model.registerCell }
    }
    func registerCell(_ value: AnyClass)  {
        model.registerCell.append(value)
    }
    
    
}

