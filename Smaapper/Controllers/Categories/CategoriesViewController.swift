//
//  CategoriesViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 13/05/23.
//

import UIKit


class CategoriesViewController: UIViewController {

    private let categories: DropdownMenuData
    
    lazy var screen: CategoriesView = {
        let home = CategoriesView()
        return home
    }()
    

    init(_ categories: DropdownMenuData) {
        self.categories = categories
        super.init(nibName: nil, bundle: nil)
        self.printarsaporra()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    private func printarsaporra() {
        categories.forEach { menu in
            print(menu.section ?? "" )
            
            menu.items?.forEach({ item in
                print(" -", item.title ?? "" )
            })
        }
    }
    
    
}
