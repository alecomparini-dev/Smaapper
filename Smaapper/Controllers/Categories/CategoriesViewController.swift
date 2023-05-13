//
//  CategoriesViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 13/05/23.
//

import UIKit


class CategoriesViewController: UIViewController {

    
    lazy var screen: CategoriesView = {
        let home = CategoriesView()
        return home
    }()
    
    
    override func loadView() {
        super.loadView()
        view = screen
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
