//
//  FloatWindowManager.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/06/23.
//

import UIKit

protocol FloatWindowManagerDelegate: AnyObject {
    func openWindow(_ floatWindow: FloatWindowViewController)
    func activatedWindow(_ activeWindow: FloatWindowViewController)
    
    func closeWindow(_ floatWindow: FloatWindowViewController)
    func deactivatedWindow(_ deactiveWindow: FloatWindowViewController)
    func allClosedWindows()
    
    func minimizedWindow(_ floatWindow: FloatWindowViewController)
    func allMinimizedWindows()
    
    func restoredWindow(_ floatWindow: FloatWindowViewController)
    func allRestoredWindows()
}

class FloatWindowManager {
    static let instance = FloatWindowManager()
    
    private weak var delegate: FloatWindowManagerDelegate?
    
    private var _listWindows: [FloatWindowViewController] = []
    private var _activeWindow: FloatWindowViewController?
    private var _lastActiveWindow: FloatWindowViewController?
    private var _desactivateWindowSuperViewControl: Bool = false
    
    
    private init() {}

    var listWindows: [FloatWindowViewController] { self._listWindows }
    var countWindows: Int { self._listWindows.count }
    var activeWindow: FloatWindowViewController? {
        get { self._activeWindow }
        set {
            if isAlreadyActivated(newValue) {return}
            self._lastActiveWindow = self._activeWindow
            if isActivationOfNilWindow(newValue) {return}
            invokeDeactivedWindow(self._activeWindow)
            self._activeWindow = newValue
            invokeActivatedWindow(self._activeWindow)
            newValue?.bringToFront
            newValue?.restore
        }
    }
    
    func addWindow(_ floatWindow: FloatWindowViewController)  {
        self._listWindows.append(floatWindow)
        delegate?.openWindow(floatWindow)
        self.activeWindow = floatWindow
        configDesactivateWindowWhenTappedSuperView()
    }
    
    func removeWindow(_ floatWindow: FloatWindowViewController)  {
        self.activateLastWindowIfNeeded(floatWindow)
        closeAnimation(floatWindow)
    }
    
    func minimize(_ floatWindow: FloatWindowViewController) {
        activateLastWindowIfNeeded(floatWindow)
        minimizeAnimation(floatWindow)
        self.delegate?.minimizedWindow(floatWindow)
    }
    
    func restore(_ floatWindow: FloatWindowViewController) {
        restoreAnimation(floatWindow)
        self.delegate?.restoredWindow(floatWindow)
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
    
    func getIndexById(_ id: UUID) -> Int? {
        if let index = listWindows.firstIndex(where: { $0.id == id }) {
            return index
        }
        return nil
    }
    

//  MARK: - PRIVATE Area
    
    private func isActivationOfNilWindow(_ newValue: FloatWindowViewController?) -> Bool {
        if newValue != nil { return false }
        invokeDeactivedWindow(self._activeWindow)
        self._activeWindow = newValue
        return true
    }
    
    private func isAlreadyActivated(_ newValue: FloatWindowViewController?) -> Bool {
        return newValue?.id == self._activeWindow?.id
    }
    
    private func invokeDeactivedWindow(_ deactiveItem: FloatWindowViewController?) {
        if let deactiveItem {
            delegate?.deactivatedWindow(deactiveItem)
        }
    }
    
    private func invokeActivatedWindow(_ activeItem: FloatWindowViewController?) {
        if let activeItem {
            delegate?.activatedWindow(activeItem)
        }
    }
    
    private func removeWindowsFromList(_ floatWindow: FloatWindowViewController) {
        self._listWindows.removeAll { $0.id == floatWindow.id }
        delegate?.deactivatedWindow(floatWindow)
        delegate?.closeWindow(floatWindow)
    }
    
    private func activateLastWindowIfNeeded(_ floatWindow: FloatWindowViewController) {
        guard let lastActiveWindow = self._lastActiveWindow else {return}
        if floatWindow.id == self._activeWindow?.id {
            if !lastActiveWindow.isMinimized {
                activeWindow = self._lastActiveWindow
                return
            }
            activeWindow = nil
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
    
    private func configDesactivateWindowWhenTappedSuperView() {
        if self._desactivateWindowSuperViewControl { return }
        
        if let superview = self.activeWindow?.superView {
            superview.isUserInteractionEnabled = true
            TapGestureBuilder(superview)
                .setTouchEnded { [weak self] tapGesture in
                    self?.activeWindow = nil
                }
            _desactivateWindowSuperViewControl = true
        }
        
    }
    
//  MARK: - ANIMATIONS Area
    
    private func minimizeAnimation(_ floatWindow: FloatWindowViewController) {
        UIView.animate(withDuration: 0.3, delay: 0 , options: .curveEaseInOut, animations: {
            floatWindow.view.alpha = 0.0
            floatWindow.view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            floatWindow.view.center = CGPoint(x: floatWindow.superView.center.x, y: floatWindow.superView.frame.maxY)
        }, completion: { _ in
            floatWindow.view.isHidden = true
        })
    }
    
    private func restoreAnimation(_ floatWindow: FloatWindowViewController) {
        floatWindow.view.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            floatWindow.view.alpha = 1
            floatWindow.view.transform = CGAffineTransform.identity
            floatWindow.view.center = floatWindow.originalCenter
        }, completion: { _ in
            
        })
    }
    
    private func closeAnimation(_ floatWindow: FloatWindowViewController) {
        UIView.animate(withDuration: 0.3, animations: {
            floatWindow.view.alpha = 0
        }, completion: { [weak self] _ in
            guard let self else {return}
            self.removeWindowsFromList(floatWindow)
            self.verifyAllClosedWindows()
            floatWindow.view.removeFromSuperview()
        })
    }
    
}



//  MARK: - EXTENSION FloatWindowManagerDelegate
extension FloatWindowManagerDelegate {
    func allMinimizedWindows() {}
    func allRestoredWindows() {}
    func allClosedWindows() {}
}
