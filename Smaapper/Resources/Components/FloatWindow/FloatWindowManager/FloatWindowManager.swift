//
//  FloatWindowManager.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/06/23.
//

import UIKit

protocol FloatWindowManagerDelegate: AnyObject {
    func allClosedWindows()
}

class FloatWindowManager {
    
    static let instance = FloatWindowManager()
    private var actions: FloatWindowManagerActions?
    
    weak var delegate: FloatWindowManagerDelegate?
    
    private var floatWindows: [FloatWindowViewController] = []
    private var _activeWindow: FloatWindowViewController?
    
    private init() {}

    var getCountWindow: Int { return self.floatWindows.count }
    var activeWindow: FloatWindowViewController? { self._activeWindow }

    func addCountWindow(_ floatWin: FloatWindowViewController)  {
        self.floatWindows.append(floatWin)
        self._activeWindow = floatWin
    }
    
    func removeCountWindow(_ floatWin: FloatWindowViewController)  {
        self.floatWindows.removeAll { $0.id == floatWin.id }
        verifyAllClosedWindows()
    }
    
    func minimizeAll() {
        floatWindows.forEach { win in
            win.minimize
        }
    }
    
    func restoreAll() {
        floatWindows.forEach { win in
            win.restore
        }
    }
    
//  MARK: - SET Actions
    func setActions(_ action: (_ build: FloatWindowManagerActions) -> FloatWindowManagerActions ) {
        if let actions = self.actions {
            self.actions = action(actions)
            return
        }
        self.actions = action(FloatWindowManagerActions())
    }


//  MARK: - PRIVATE Area
    private func verifyAllClosedWindows() {
        if self.getCountWindow == 0 {
            delegate?.allClosedWindows()
        }
    }
    
}
