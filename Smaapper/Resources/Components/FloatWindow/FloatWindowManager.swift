//
//  FloatWindowManager.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/06/23.
//

import UIKit

protocol FloatWindowManagerDelegate: AnyObject {
    
    func viewDidLoad(_ floatWindow: FloatWindowViewController)
    func viewWillAppear(_ floatWindow: FloatWindowViewController)
    func viewWillLayoutSubviews(_ floatWindow: FloatWindowViewController)
    func viewDidLayoutSubviews(_ floatWindow: FloatWindowViewController)
    func viewDidAppear(_ floatWindow: FloatWindowViewController)
    func viewWillDragging(_ floatWindow: FloatWindowViewController)
    func viewDragging(_ floatWindow: FloatWindowViewController)
    func viewEndedDragging(_ floatWindow: FloatWindowViewController)
    func viewMinimized(_ floatWindow: FloatWindowViewController)
    func viewRestored(_ floatWindow: FloatWindowViewController)
    func viewActivated(_ floatWindow: FloatWindowViewController)
    func viewDesactivated(_ floatWindow: FloatWindowViewController)
    func viewWillDisappear(_ floatWindow: FloatWindowViewController)
    func viewDidDisappear(_ floatWindow: FloatWindowViewController)
    
    
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
    
    var lastActiveWindow: FloatWindowViewController? {self._lastActiveWindow}
    var activeWindow: FloatWindowViewController? {
        get { self._activeWindow }
        set {
            print(#function, #fileID)
            self._lastActiveWindow = self._activeWindow
            if isActivate(newValue) {return}
            
            if let _activeWindow {
                delegate?.viewDesactivated(_activeWindow)
            }
            
            self._activeWindow = newValue
            
            if let _activeWindow {
                delegate?.viewActivated(_activeWindow)
            }
        }
    }
    

    
    func deactiveWindow (_ floatWindow: FloatWindowViewController) {
        debugPrint(#function, #fileID)
        if isActivate(floatWindow) {
            self.activeWindow = nil
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func addWindowToManager(_ floatWindow: FloatWindowViewController)  {
        debugPrint(#function, #fileID)
        self._listWindows.append(floatWindow)
    }
    
    func removeWindowToManager(_ floatWindow: FloatWindowViewController)  {
        debugPrint(#function, #fileID)
        self._listWindows.removeAll { $0.id == floatWindow.id }
    }
    
    func minimizeAll() {
        self._listWindows.forEach { win in
            win.viewMinimized()
        }
    }
    
    func restoreAll() {
        self._listWindows.forEach { win in
            win.viewRestored()
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
    
    func isActivate(_ newValue: FloatWindowViewController?) -> Bool {
        debugPrint(#function, #fileID)
        return newValue?.id == self._activeWindow?.id
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
                self?.lastActiveWindow?.viewDesactivated()
                self?._activeWindow = nil
                self?._lastActiveWindow = nil
            }
        _desactivateWindowSuperViewControl = true
    }
    

}


extension FloatWindowManagerDelegate {
    func viewDidLoad(_ floatWindow: FloatWindowViewController) {}
    func viewWillAppear(_ floatWindow: FloatWindowViewController) {}
    func viewWillLayoutSubviews(_ floatWindow: FloatWindowViewController) {}
    func viewDidLayoutSubviews(_ floatWindow: FloatWindowViewController) {}
    func viewDidAppear(_ floatWindow: FloatWindowViewController) {}
    func viewWillDragging(_ floatWindow: FloatWindowViewController) {}
    func viewDragging(_ floatWindow: FloatWindowViewController) {}
    func viewEndedDragging(_ floatWindow: FloatWindowViewController) {}
    func viewMinimized(_ floatWindow: FloatWindowViewController) {}
    func viewRestored(_ floatWindow: FloatWindowViewController) {}
    func viewWillDisappear(_ floatWindow: FloatWindowViewController) {}
    func viewDidDisappear(_ floatWindow: FloatWindowViewController) {}
    func allClosedWindows() {}
}

