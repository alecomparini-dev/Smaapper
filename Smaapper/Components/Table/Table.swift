//
//  Table.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 03/04/23.
//

import UIKit


class Table {

    private let table: TableView = TableView()
    private let tableVM = TableViewModel()
    
    var view: TableView { table }
    
    
    
//  MARK: - SET PROPERTIES OF COMPONENT
    
    func setSeparatorStyle( _ separatorStyle: UITableViewCell.SeparatorStyle) -> Self {
        tableVM.separatorStyle = separatorStyle
        return self
    }
    
    func setShowsScroll(_ showsScroll: ShowsScroll) -> Self {
        tableVM.showsScroll = showsScroll
        return self
    }
    
    func setScrollEnabled(_ flag: Bool) -> Self {
        tableVM.isScrollEnabled = flag
        return self
    }
    
    func setRegisterCell(_ cell: AnyClass ) -> Self {
        tableVM.registerCell(cell)
        return self
    }
    
    func setTransform(_ transform: CGAffineTransform ) -> Self {
        tableVM.transform = transform
        return self
    }
    
    func setTableFooter(_ tableFooter: UIView ) -> Self {
        tableVM.tableFooter = tableFooter
        return self
    }
    
    
    
//  MARK: - BUILD COMPONENT
    func build() -> Self {
        buildSeparatorStyle()
        buildShowsScroll()
        buildScrollEnabled()
        buildTransform()
        buildTableFooter()
        buildRegisterCell()
        return self
    }
    
    private func buildSeparatorStyle() {
        guard let separatorStyle = tableVM.separatorStyle else { return }
        table.customSeparatorStyle(separatorStyle)
    }
    
    private func buildShowsScroll() {
        guard let showsScroll = tableVM.showsScroll else {
            table.customShowsScroll(.both, false)
            return
        }
        table.customShowsScroll(showsScroll, true)
    }
    
    private func buildScrollEnabled() {
        guard let isScrollEnabled = tableVM.isScrollEnabled else { return }
        table.customIsScrollEnabled(isScrollEnabled)
    }
    
    
    private func buildTransform() {
        guard let transform = tableVM.transform else { return }
        table.customTransform(transform)
    }
    
    private func buildTableFooter() {
        guard let tableFooter = tableVM.tableFooter else { return }
        table.customTableFooter(tableFooter)
    }
    
    
    
    private func buildRegisterCell() {
        if tableVM.registerCell.count == 0 {
            debugPrint("Table without registered cell !")
            return
        }
        tableVM.registerCell.forEach { cell in
            table.customRegisterCell(cell)
        }
    }
    
    
    
//  MARK: - DELEGATE
    func delegate(_ delegate: UIViewController) {
        let delegate: UITableViewDelegate = delegate as! UITableViewDelegate
        let dataSource: UITableViewDataSource = delegate as! UITableViewDataSource
        table.delegate(delegate, dataSource)
    }
    
    
//  MARK: - ACTION
    func reloadTableView() {
        table.reloadTable()
    }
    
    
}
