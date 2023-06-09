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
    func viewWillDisappear(_ floatView: FloatViewController)
    func viewDidDisappear(_ floatView: FloatViewController)
    func viewShouldSelectFloatView(_ floatView: FloatViewController)
    func viewDidSelectFloatView(_ floatView: FloatViewController)
    func viewDidDeselectFloatView(_ floatView: FloatViewController)
    func allClosedWindows()
}

class FloatViewControllerManager {
    static let instance = FloatViewControllerManager()
    
    weak var delegate: FloatViewControllerManagerDelegate?
    
    private var _listWindows: [FloatViewController] = []
    private var enableDeactivationFloatViewWhenTappedSuperview: TapGestureBuilder?
    
    
    private init() {}

    var listFloatView: [FloatViewController] { self._listWindows }
    var countFloatView: Int { self._listWindows.count }
    var countFloatViewMinimized: Int { self._listWindows.filter { $0.isMinimized }.count }
        
    func floatViewSelected() -> FloatViewController? {
        return listFloatView.first(where: { $0.active })
    }
    
    func addFloatView(_ floatView: FloatViewController)  {
        self._listWindows.append(floatView)
    }
    
    func removeWindowToManager(_ floatView: FloatViewController)  {
        self._listWindows.removeAll { $0.id == floatView.id }
    }
    
    func getIndex(_ floatView: FloatViewController) -> Int? {
        if let index = listFloatView.firstIndex(where: { $0.id == floatView.id }) {
            return index
        }
        return nil
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
    
    func verifyAllClosedWindows() {
        if self.countFloatView == 0 {
            delegate?.allClosedWindows()
        }
    }
    
    func enableDeactivationFloatViewWhenTappedSuperview(_ superView: UIView) {
        if enableDeactivationFloatViewWhenTappedSuperview == nil {
            setTapGestureOnSuperview(superView)
        }
    }
    
    
//  MARK: - PRIVATE Area
    
    private func setTapGestureOnSuperview(_ superView: UIView) {
        enableDeactivationFloatViewWhenTappedSuperview = TapGestureBuilder(superView)
            .setCancelsTouchesInView(true)
            .setTouchEnded { [weak self] tapGesture in
                guard let self else {return}
                superView.endEditing(true)
                floatViewSelected()?.deselect
            }
    }
    
    func removeDeactivationFloatViewWhenTappedSuperview() {
        if self.countFloatView == 0 || isAllMinimized() {
            enableDeactivationFloatViewWhenTappedSuperview?.removeTapGesture()
            enableDeactivationFloatViewWhenTappedSuperview = nil
        }
    }
    
    func isAllMinimized() -> Bool {
        return countFloatView == countFloatViewMinimized
    }

    
//  MARK: - DELEGATE
    
    func setDelegate(_ delegate: FloatViewControllerManagerDelegate) {
        self.delegate = delegate
    }
}


//  MARK: - EXTENSION FloatViewControllerManagerDelegate

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
    func viewWillDisappear(_ floatView: FloatViewController) { }
    func viewDidDisappear(_ floatView: FloatViewController) { }
    func viewShouldSelectFloatView(_ floatView: FloatViewController) { }
    func viewDidSelectFloatView(_ floatView: FloatViewController) { }
    func viewDidDeselectFloatView(_ floatView: FloatViewController) { }
    func allClosedWindows() { }
}

