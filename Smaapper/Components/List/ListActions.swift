//
//  ListActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 25/05/23.
//

import UIKit


class ListActions {
    
    typealias didSelectRow = (_ section: Int, _ row: Int) -> Void
    private var didSelectRow: didSelectRow?
    
    private let listBuilder: ListBuilder
    
    init(_ listBuilder: ListBuilder) {
        self.listBuilder = listBuilder
        configListDelegate()
    }
    
    
//  MARK: - SET Actions
    
    @discardableResult
    func setAction(didSelectRow closure: @escaping didSelectRow) -> Self {
        self.didSelectRow = closure
        return self
    }
    
    
//  MARK: - Private Area
    private func configListDelegate() {
        listBuilder.list.listDelegate = self
    }
    
}

extension ListActions: ListActionsDelegate {
    
    func didSelectRow(_ section: Int, _ row: Int) {
        self.didSelectRow?(section,row)
    }
    
}
