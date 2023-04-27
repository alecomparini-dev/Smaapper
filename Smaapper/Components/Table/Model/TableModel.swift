//
//  TableModel.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 03/04/23.
//

import UIKit

struct TableModel {
    
    var separatorStyle: UITableViewCell.SeparatorStyle? = nil
    var showsScroll: ShowsScroll? = nil
    var isScrollEnabled: Bool? = nil
    var registerCell: [AnyClass] = []
    var transform: CGAffineTransform? = nil
    var tableFooter: UIView? = nil
}
