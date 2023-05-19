//
//  FloatWindow.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 19/05/23.
//

import UIKit


class FloatWindow: View {
    
    private var titleWindow: TitleWindow?
    private var _isShow = false
    private var alreadyApplied = false
    
    private let hierarchy: CGFloat = 1000
    
    override init() {
        super.init()
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        self.layer.zPosition = hierarchy
    }
    
    
//  MARK: - SET Properties
    
    @discardableResult
    func setTitleWindow(_ titleWindow: (_ build: TitleWindow) -> TitleWindow) -> Self {
        self.titleWindow = titleWindow(TitleWindow())
        return self
    }
    

    var isShow: Bool {
        get { return self._isShow}
        set {
            self._isShow = newValue
            applyOnceConfig()
            self.isHidden = !self._isShow
        }
    }
    
    
//  MARK: - Private Function Area
    
    private func applyOnceConfig() {
        if self._isShow && !alreadyApplied {
//            DispatchQueue.main.async {
                self.alreadyApplied = true
//            }
        }
    }
    
    
    
}
