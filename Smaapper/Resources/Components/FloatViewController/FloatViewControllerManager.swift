//
//  FloatWindowManager.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/06/23.
//

import UIKit

protocol FloatViewControllerManagerDelegate: AnyObject {
    
    func viewDidLoad(_ floatWindow: FloatViewController)
    func viewWillAppear(_ floatWindow: FloatViewController)
    func viewWillLayoutSubviews(_ floatWindow: FloatViewController)
    func viewDidLayoutSubviews(_ floatWindow: FloatViewController)
    func viewDidAppear(_ floatWindow: FloatViewController)
    func viewWillDrag(_ floatWindow: FloatViewController)
    func viewDragging(_ floatWindow: FloatViewController)
    func viewDidDrag(_ floatWindow: FloatViewController)
    
    func viewWillMinimize(_ floatWindow: FloatViewController)
    func viewDidMinimize(_ floatWindow: FloatViewController)
    
    func viewWillRestore(_ floatWindow: FloatViewController)
    func viewDidRestore(_ floatWindow: FloatViewController)
    func viewActivated(_ floatWindow: FloatViewController)
    func viewDesactivated(_ floatWindow: FloatViewController)
    func viewWillDisappear(_ floatWindow: FloatViewController)
    func viewDidDisappear(_ floatWindow: FloatViewController)
    
    
    func allClosedWindows()
    
}

class FloatViewControllerManager {
    static let instance = FloatViewControllerManager()
    
    weak var delegate: FloatViewControllerManagerDelegate?
    
    private var _listWindows: [FloatViewController] = []
    private var _desactivateWindowSuperViewControl: Bool = false
    
    private init() {}

    var lastActive: FloatViewController?
    
    var listWindows: [FloatViewController] { self._listWindows }
    var countWindows: Int { self._listWindows.count }
    
    
    func windowActive() -> FloatViewController? {
        return listWindows.first(where: { $0.active })
    }
    
    func lastWindowActive() -> FloatViewController? {
        return self.lastActive
    }
    
    func addWindowToManager(_ floatWindow: FloatViewController)  {
        self._listWindows.append(floatWindow)
    }
    
    func removeWindowToManager(_ floatWindow: FloatViewController)  {
        self._listWindows.removeAll { $0.id == floatWindow.id }
    }
    
    func minimizeAll() {
        self._listWindows.forEach { win in
            win.viewMinimize()
        }
    }
    
    func restoreAll() {
        self._listWindows.forEach { win in
            win.restore
        }
    }
    
    func setDelegate(_ delegate: FloatViewControllerManagerDelegate) {
        self.delegate = delegate
    }
    
    func getIndexById(_ id: UUID) -> Int? {
        if let index = listWindows.firstIndex(where: { $0.id == id }) {
            return index
        }
        return nil
    }
    

//  MARK: - PRIVATE Area
    
    
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
                guard let self else {return}
                lastActive = nil
                windowActive()?.viewDesactivated()
            }
        _desactivateWindowSuperViewControl = true
    }
    

}


extension FloatViewControllerManagerDelegate {
    func viewDidLoad(_ floatWindow: FloatViewController) {}
    func viewWillAppear(_ floatWindow: FloatViewController) {}
    func viewWillLayoutSubviews(_ floatWindow: FloatViewController) {}
    func viewDidLayoutSubviews(_ floatWindow: FloatViewController) {}
    func viewDidAppear(_ floatWindow: FloatViewController) {}
    func viewWillDrag(_ floatWindow: FloatViewController) {}
    func viewDragging(_ floatWindow: FloatViewController) {}
    func viewDidDrag(_ floatWindow: FloatViewController) {}
    func viewDidMinimize(_ floatWindow: FloatViewController) {}
    func viewWillMinimize(_ floatWindow: FloatViewController) {}
    func viewDidRestore(_ floatWindow: FloatViewController) {}
    func viewWillRestore(_ floatWindow: FloatViewController) {}
    func viewWillDisappear(_ floatWindow: FloatViewController) {}
    func viewDidDisappear(_ floatWindow: FloatViewController) {}
    func allClosedWindows() {}
}
