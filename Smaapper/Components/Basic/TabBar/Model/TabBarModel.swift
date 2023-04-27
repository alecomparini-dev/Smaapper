//
//  TabBarModel.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 03/04/23.
//

import UIKit

struct TabBarModel {
    var items: [TabBarItemModel] = []
    var isTranslucent: Bool = false
    var tintColor: UIColor? = nil
    var backgroundColor: UIColor? = nil
    var unselectedItemTintColor: UIColor? = nil
    var useNavigationController: Bool = false
    var activateUnderline: Bool = false
}
