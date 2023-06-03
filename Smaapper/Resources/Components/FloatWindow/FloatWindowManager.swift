//
//  FloatWindowManager.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/06/23.
//

import UIKit

protocol FloatWindowManagerDelegate: AnyObject {
    func allClosedWindows()
    func allMinimizedWindows()
    func allRestoredWindows()
    func deactivatedWindow(_ deactiveWindow: FloatWindowViewController)
    func activatedWindow(_ activeWindow: FloatWindowViewController)
}

class FloatWindowManager {
    
    static let instance = FloatWindowManager()
    
    private weak var delegate: FloatWindowManagerDelegate?
    
    private var floatWindows: [FloatWindowViewController] = []
    private var _activeWindow: FloatWindowViewController?
    private var _lastActiveWindow: FloatWindowViewController?
    
    private init() {}

    var getCountWindow: Int { return self.floatWindows.count }
    var activeWindow: FloatWindowViewController? {
        get { self._activeWindow }
        set {
            invokeActivatedDeactivatedWindow(newValue)
            self._lastActiveWindow = self._activeWindow
            self._activeWindow = newValue
        }
    }

    func addWindow(_ floatWindow: FloatWindowViewController)  {
        self.floatWindows.append(floatWindow)
        self.activeWindow = floatWindow
    }
    
    func removeWindow(_ floatWindow: FloatWindowViewController)  {
        self.floatWindows.removeAll { $0.id == floatWindow.id }
        if floatWindow.id == self._activeWindow?.id {
            self._activeWindow = nil
        }
        activeWindow = self._lastActiveWindow
        verifyAllClosedWindows()
    }
    
    func minimizeAll() {
        floatWindows.forEach { win in
            win.minimize
        }
        delegate?.allMinimizedWindows()
    }
    
    func restoreAll() {
        floatWindows.forEach { win in
            win.restore
        }
        delegate?.allRestoredWindows()
    }
    
    func setDelegate(_ delegate: FloatWindowManagerDelegate) {
        self.delegate = delegate
    }
    


//  MARK: - PRIVATE Area
    private func verifyAllClosedWindows() {
        if self.getCountWindow == 0 {
            delegate?.allClosedWindows()
        }
    }
    
    private func invokeActivatedDeactivatedWindow(_ newValue: FloatWindowViewController?) {
        guard let newValue else { return }
        
        if newValue.id == self._activeWindow?.id { return }
        
        if let activeWin = self._activeWindow {
            invokeDeactivedWindow(activeWin)
        }
        invokeActivatedWindow(newValue)
    }
    
    private func invokeDeactivedWindow(_ deactiveWin: FloatWindowViewController) {
        delegate?.deactivatedWindow(deactiveWin)
    }
    
    private func invokeActivatedWindow(_ activeWin: FloatWindowViewController) {
        delegate?.activatedWindow(activeWin)
    }
    
}



//  MARK: - EXTENSION FloatWindowManagerDelegate
extension FloatWindowManagerDelegate {
    func allMinimizedWindows() {}
    func allRestoredWindows() {}
    func allClosedWindows() {}
}
