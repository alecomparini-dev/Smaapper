//
//  DockController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/06/23.
//

import UIKit


class HomeViewDockController {
    
    private let floatManager = FloatViewControllerManager.instance
    
    private var adjustTrailingDock = NSLayoutConstraint()
    
    private var dock = DockBuilder()
    
    init() { }
    
    init(_ dock: DockBuilder) {
        self.dock = dock
    }
    


//  MARK: - DELEGATE
    func setDelegate(_ delegate: DockDelegate) {
        dock.setDelegate(delegate)
    }
    
    
//  MARK: - PUBLIC Area
    
    var isShow: Bool {
        get { dock.isShow }
        set { dock.isShow = newValue}
    }
    
    func setDockAlignment() {
        if floatManager.countFloatView == 4 {
            self.adjustTrailingDock.constant = -50
        }

        if floatManager.countFloatView > 4 {
            self.adjustTrailingDock.constant = -90
        }
    }
    
    func verifyShowDock() {
        setDockAlignment()
        if isShowDockIfOneWindow() {
            dock.isShow = true
            return
        }
        if isShowDockIfMoreThanOneWindow() {
            dock.isShow = true
            return
        }
        dock.isShow = false
    }

    func minimizedItemDock(_ floatWindow: FloatViewController, reload: Bool = false) {
        if let index = floatManager.getIndex(floatWindow) {
            dock.getCellByIndex(index) { [weak self] cellItem in
                self?.minimizeItemDock(cellItem, reload)
            }
        }
    }
    
    func setShadowItemDock() {
        
        dock.getCellSelected { cellItem in
            ShadowBuilder(cellItem.subviews[0].subviews[0])
                .setColor(Theme.shared.currentTheme.primary.adjustBrightness(20))
                .setOffset(width: 0, height: 0)
                .setOpacity(1)
                .setRadius(2)
                .setBringToFront()
                .setID("activeItemDock")
                .apply()
        }
    }
    
    func removeShadowItemDock(_ indexItem: Int) {
        dock.getCellByIndex(indexItem) { cellItem in
            cellItem.subviews[0].subviews[0].removeShadowByID("activeItemDock")
        }
    }
    
    func restoredItemDock(_ floatWindow: FloatViewController) {
        if let index = floatManager.getIndex(floatWindow) {
            dock.getCellByIndex(index) { [weak self] cellItem in
                self?.restoreItemDock(cellItem)
            }
        }
    }
    
    func configItemDock(_ indexItem: Int) {
        let win = floatManager.listFloatView[indexItem]
        if win.isMinimized {
            minimizedItemDock(win, reload: true)
        }
        if win.active {
            setShadowItemDock()
        }
    }
    
    
//  MARK: - MANIPULATION DOCK
    
    func insertItem(_ indexItem: Int) {
        dock.insertItem(indexItem)
    }
    
    func selectItem(_ indexItem: Int, at: UICollectionView.ScrollPosition) {
        dock.selectItem(indexItem, at: at)
    }
    
    func deselect(_ indexItem: Int) {
        dock.deselect(indexItem)
    }
    
    func removeItem(_ indexItem: Int) {
        dock.removeItem(indexItem)
    }
    
    func isSelected(_ indexItem: Int) -> Bool {
        return dock.isSelected(indexItem)
    }
    
    
//  MARK: - PRIVATE Area
    func setConstraintAlignmentHorizontalDock(_ view: UIView) {
        self.adjustTrailingDock = dock.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        adjustTrailingDock.isActive = true
        setDockAlignment()
    }
    
    private func isShowDockIfOneWindow() -> Bool {
        if (floatManager.countFloatView == 1 ) {
            if floatManager.listFloatView[0].isMinimized { return true }
        }
        return false
    }
    
    private func isShowDockIfMoreThanOneWindow() -> Bool {
        if floatManager.countFloatView >= 2 { return true }
        return false
    }

    private func minimizeItemDock(_ cellItem: UIView, _ reload: Bool = false)  {
        let duration = (reload) ? 0.0 : 0.3
        UIView.animate(withDuration: duration) {
            cellItem.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }

    private func restoreItemDock(_ cellItem: UIView) {
        UIView.animate(withDuration: 0.3) {
            cellItem.transform = CGAffineTransform.identity
        }
    }
    
    
    
}
