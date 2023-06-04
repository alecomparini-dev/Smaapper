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
    
    private var _listWindows: [FloatWindowViewController] = []
    private var _activeWindow: FloatWindowViewController?
    private var _lastActiveWindow: FloatWindowViewController?
    private var _desactivateWindowSuperView: Bool = false
    
    
    private init() {}

    var listWindows: [FloatWindowViewController] { self._listWindows }
    var countWindows: Int { self._listWindows.count }
    var activeWindow: FloatWindowViewController? {
        get { self._activeWindow }
        set {
            self._lastActiveWindow = self._activeWindow
            invokeActivatedDeactivatedWindow(newValue)
            newValue?.bringToFront
            self._activeWindow = newValue
        }
    }
    

    func addWindow(_ floatWindow: FloatWindowViewController)  {
        self._listWindows.append(floatWindow)
        self.activeWindow = floatWindow
    }
    
    func removeWindow(_ floatWindow: FloatWindowViewController)  {
        removeWindowsFromList(floatWindow)
        activateLastWindowIfNeeded(floatWindow)
        verifyAllClosedWindows()
    }
    
    func minimizeAll() {
        self._listWindows.forEach { win in
            win.minimize
        }
        delegate?.allMinimizedWindows()
    }
    
    func restoreAll() {
        self._listWindows.forEach { win in
            win.restore
        }
        delegate?.allRestoredWindows()
    }
    
    func setDelegate(_ delegate: FloatWindowManagerDelegate) {
        self.delegate = delegate
    }
    


//  MARK: - PRIVATE Area
    private func removeWindowsFromList(_ floatWindow: FloatWindowViewController) {
        self._listWindows.removeAll { $0.id == floatWindow.id }
    }
    
    private func activateLastWindowIfNeeded(_ floatWindow: FloatWindowViewController){
        if floatWindow.id == self._activeWindow?.id {
            activeWindow = self._lastActiveWindow
        }
    }
    
    private func verifyAllClosedWindows() {
        if self.countWindows == 0 {
            delegate?.allClosedWindows()
        }
    }
    
    private func invokeActivatedDeactivatedWindow(_ newValue: FloatWindowViewController?) {
        guard let newValue else {
            if let lastActiveWindow = self._lastActiveWindow {
                invokeDeactivedWindow(lastActiveWindow)
            }
            return
        }
        
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
    
    func desactivateWindowOnClickSuperView() {
        if self._desactivateWindowSuperView { return }
        
        if let superview = self.activeWindow?.superView {
            superview.isUserInteractionEnabled = true
            TapGestureBuilder(superview)
                .setTouchEnded { [weak self] tapGesture in
                    self?.activeWindow = nil
                }
            _desactivateWindowSuperView = true
        }
        
    }
    
}



//  MARK: - EXTENSION FloatWindowManagerDelegate
extension FloatWindowManagerDelegate {
    func allMinimizedWindows() {}
    func allRestoredWindows() {}
    func allClosedWindows() {}
}
