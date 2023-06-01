//
//  FloatWindowManager.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/06/23.
//

import UIKit


class FloatWindowManager {
    
    static let instance = FloatWindowManager()
    
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
    }
    

    func minimizeAll() {
        
    }
    
    func maximizeAll() {
        
    }
    
    func restoreAll() {
        
    }


    
}
