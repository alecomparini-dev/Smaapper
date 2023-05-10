//
//  HomeVC.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/04/23.
//

import UIKit

class HomeVC: UIViewController {
    
    private let viewModel = HomeViewModel()
    
    private var turnOnMenuButton = false
    private var openDropdownMenu = false
    
    lazy var homeScreen: HomeView = {
        let home = HomeView()
        home.translatesAutoresizingMaskIntoConstraints = false
        return home
    }()
    
    override func loadView() {
        super.loadView()
        view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configDelegate()
        configDropdownMenu()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
//  MARK: - Private Function Area
    
    private func configDelegate() {
        homeScreen.delegate = self
    }
    
    private func configDropdownMenu() {
        viewModel.fetchDropdownMenu(.file) { result, error in
            if error == nil {
                if let result {
                    self.loadDropdownMenu(result)
                }
            }
        }
    }
    
    private func loadDropdownMenu(_ dropdownMenu: DropdownMenuData) {
        
    }
    
    private func openCloseDropdownMenu() {
        if openDropdownMenu {
            homeScreen.dropdownMenu.hide()
        } else {
            homeScreen.dropdownMenu.show()
        }
        openDropdownMenu = !openDropdownMenu
    }
    
    private func turnOnOffMenuButton() {
        if turnOnMenuButton {
            homeScreen.turnOffMenuButton()
        } else {
            homeScreen.turnOnMenuButton()
        }
        turnOnMenuButton = !turnOnMenuButton
    }
    
}


//  MARK: - Extension HomeViewDelegate
extension HomeVC: HomeViewDelegate {
    func menuButtonTapped() {
        openCloseDropdownMenu()
        turnOnOffMenuButton()
    }
    
}
