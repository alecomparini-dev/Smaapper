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
    
    weak var delegate: FloatWindowManagerDelegate?
    
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
            print(#function, #fileID)
            if isActivated(newValue) {return}
            self._lastActiveWindow = self._activeWindow
            self._activeWindow?.viewDesactivated()
            self._activeWindow = newValue
        }
    }
    
    func deactiveWindow (_ floatWindow: FloatWindowViewController?) {
        print(#function, #fileID)
        if isActivated(floatWindow) {
            self._activeWindow = nil
            return
        }
        
    }
    
    func addWindowToManager(_ floatWindow: FloatWindowViewController)  {
        print(#function, #fileID)
        self._listWindows.append(floatWindow)
    }
    
    func removeWindowToManager(_ floatWindow: FloatWindowViewController)  {
        print(#function, #fileID)
        self._listWindows.removeAll { $0.id == floatWindow.id }
    }
    
    
    func minimizeAll() {
        self._listWindows.forEach { win in
            win.minimize
        }
    }
    
    func restoreAll() {
        self._listWindows.forEach { win in
            win.restore
        }
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
    
    private func isActivated(_ newValue: FloatWindowViewController?) -> Bool {
        print(#function, #fileID)
        return newValue?.id == self._activeWindow?.id
    }
    
    
    private func activateLastWindowIfNeeded(_ floatWindow: FloatWindowViewController) {
        guard let lastActiveWindow = self._lastActiveWindow else {
            activeWindow = nil
            return
        }
        if floatWindow.id == self._activeWindow?.id {
            if !lastActiveWindow.isMinimized {
                activeWindow = self._lastActiveWindow
                return
            }
            activeWindow = nil
        }
    }
    
    func verifyAllClosedWindows() {
        if self.countWindows == 0 {
            delegate?.allClosedWindows()
        }
    }
    
        
    func configDesactivateWindowWhenTappedSuperView(_ superView: UIView) {
        if self._desactivateWindowSuperViewControl { return }
        
        superView.isUserInteractionEnabled = true
        TapGestureBuilder(superView)
            .setTouchEnded { [weak self] tapGesture in
                self?.activeWindow?.viewDesactivated()
            }
        _desactivateWindowSuperViewControl = true
    }
    

}


