//
//  TableView.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 03/04/23.
//

import UIKit

class TableView: UITableView {


    func customSeparatorStyle( _ separatorStyle: UITableViewCell.SeparatorStyle) {
        self.separatorStyle = separatorStyle
    }
    
    func customShowsScroll(_ showsScroll: ShowsScroll, _ flag: Bool){
        switch showsScroll {
        case .horizontal:
            self.showsHorizontalScrollIndicator = flag
        case .vertical:
            self.showsVerticalScrollIndicator = flag
        case .both:
            self.showsVerticalScrollIndicator = flag
            self.showsHorizontalScrollIndicator = flag
        }
    }
    
    func customIsScrollEnabled(_ flag: Bool) {
        self.isScrollEnabled = flag
    }
    
    func customTransform(_ transform: CGAffineTransform) {
        self.transform = transform
    }
    
    func customTableFooter(_ tableFooter: UIView) {
        self.tableFooterView = tableFooter
    }
    
    func customRegisterCell(_ cell: AnyClass ) {
        register(cell, forCellReuseIdentifier: String(describing: cell.self))
    }
    
//  MARK: - ACTION
    func reloadTable() {
        self.reloadData()
    }
    
//  MARK: - DELEGATE
    func delegate(_ delegate: UITableViewDelegate, _ dataSource: UITableViewDataSource) {
        self.delegate = delegate
        self.dataSource = dataSource
    }
    
}
