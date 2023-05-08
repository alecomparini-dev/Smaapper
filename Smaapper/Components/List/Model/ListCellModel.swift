//
//  ListCellModel.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/05/23.
//

import UIKit

struct ListCellModel {
    let isSection: Bool
    let leftView: UIView?
    let middleView: UIView
    let rightView: UIView?
    let completion: ((_ row: Int, _ section: Int?) -> Void)?
}
