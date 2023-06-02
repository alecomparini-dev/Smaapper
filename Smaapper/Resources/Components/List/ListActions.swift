//
//  ListActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 25/05/23.
//

import UIKit


class ListActions {
    
    typealias didSelectRowAlias = (_ section: Int, _ row: Int) -> Void
    
    private var didSelectRow: [didSelectRowAlias] = []
    
    private let listBuilder: ListBuilder
    
    init(_ listBuilder: ListBuilder) {
        self.listBuilder = listBuilder
        configListDelegate()
    }
    
    
//  MARK: - SET Actions
    
    @discardableResult
    func setDidSelectRow(_ closure: @escaping didSelectRowAlias) -> Self {
        self.didSelectRow.append(closure)
        return self
    }
    
    
//  MARK: - Private Area
    private func configListDelegate() {
        listBuilder.view.listDelegate = self
    }
    
}


//  MARK: - Extension ListActionsDelegate

extension ListActions: ListActionsDelegate {
    
    func didSelectRow(_ section: Int, _ row: Int) {
        self.didSelectRow.forEach { closure in
            closure(section,row)
        }
    }
    
}
