//
//  TabBarViewModel.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 03/04/23.
//

import UIKit

class TabBarViewModel {

    private var model = TabBarModel()
    
    var items: [TabBarItemModel] { model.items }
//    func items(_ item: UIViewController, _ imageItem: ImageView) {
//        let tabBarItemModel = TabBarItemModel(item: item, imageView: imageItem)
//        model.items.append(tabBarItemModel)
//    }
//    
    var isTranslucent: Bool {
        get { model.isTranslucent }
        set { model.isTranslucent = newValue }
    }
    
    var activateUnderline: Bool {
        get { model.activateUnderline }
        set { model.activateUnderline = newValue }
    }
    
    var unselectedItemTintColor: UIColor? {
        get { model.unselectedItemTintColor }
        set { model.unselectedItemTintColor = newValue }
    }
    
    var tintColor: UIColor? {
        get { model.tintColor }
        set { model.tintColor = newValue }
    }
    
    var backgroundColor: UIColor? {
        get { model.backgroundColor }
        set { model.backgroundColor = newValue }
    }
    
    var useNavigationController: Bool {
        get { model.useNavigationController }
        set { model.useNavigationController = newValue }
    }
    
}
