//
//  floatViewManager.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/06/23.
//

import UIKit

protocol FloatViewControllerManagerDelegate: AnyObject {
    
    func viewDidLoad(_ floatView: FloatViewController)
    func viewWillAppear(_ floatView: FloatViewController)
    func viewWillLayoutSubviews(_ floatView: FloatViewController)
    func viewDidLayoutSubviews(_ floatView: FloatViewController)
    func viewDidAppear(_ floatView: FloatViewController)
    func viewWillDrag(_ floatView: FloatViewController)
    func viewDragging(_ floatView: FloatViewController)
    func viewDidDrag(_ floatView: FloatViewController)
    
    func viewWillMinimize(_ floatView: FloatViewController)
    func viewDidMinimize(_ floatView: FloatViewController)
    
    func viewWillRestore(_ floatView: FloatViewController)
    func viewDidRestore(_ floatView: FloatViewController)
    func viewActivated(_ floatView: FloatViewController)
    func viewDesactivated(_ floatView: FloatViewController)
    func viewWillDisappear(_ floatView: FloatViewController)
    func viewDidDisappear(_ floatView: FloatViewController)
    
    
    func allClosedWindows()
    func didSelectedFloatView(_ floatView: FloatViewController)
    
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
    
    func addWindowToManager(_ floatView: FloatViewController)  {
        self._listWindows.append(floatView)
    }
    
    func removeWindowToManager(_ floatView: FloatViewController)  {
        self._listWindows.removeAll { $0.id == floatView.id }
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
    
    func getIndex(_ floatView: FloatViewController) -> Int? {
        if let index = listWindows.firstIndex(where: { $0.id == floatView.id }) {
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
    func viewDidLoad(_ floatView: FloatViewController) { }
    func viewWillAppear(_ floatView: FloatViewController) { }
    func viewWillLayoutSubviews(_ floatView: FloatViewController) { }
    func viewDidLayoutSubviews(_ floatView: FloatViewController) { }
    func viewDidAppear(_ floatView: FloatViewController) { }
    func viewWillDrag(_ floatView: FloatViewController) { }
    func viewDragging(_ floatView: FloatViewController) { }
    func viewDidDrag(_ floatView: FloatViewController) { }
    func viewWillMinimize(_ floatView: FloatViewController) { }
    func viewDidMinimize(_ floatView: FloatViewController) { }
    func viewWillRestore(_ floatView: FloatViewController) { }
    func viewDidRestore(_ floatView: FloatViewController) { }
    func viewActivated(_ floatView: FloatViewController) { }
    func viewDesactivated(_ floatView: FloatViewController) { }
    func viewWillDisappear(_ floatView: FloatViewController) { }
    func viewDidDisappear(_ floatView: FloatViewController) { }
    func allClosedWindows() { }
    func didSelectedFloatView(_ floatView: FloatViewController) { }
}

