//
//  HomeVC.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/04/23.
//

import UIKit

class HomeVC: UIViewController {
    
    lazy var home: Home = {
        let home = Home()
        home.translatesAutoresizingMaskIntoConstraints = false
        return home
    }()
    
    override func loadView() {
        super.loadView()
        view = home
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
