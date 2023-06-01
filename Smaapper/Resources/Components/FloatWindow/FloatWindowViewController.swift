//
//  FloatWindowViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 19/05/23.
//

import UIKit


class FloatWindowViewController: ViewBuilder {
    
    private var _isShow = false
    private var alreadyApplied = false
    private let hierarchy: CGFloat = 1000
    private var _superView: UIView?
    private(set) var id: UUID = UUID()
    
    private var sizeWindow: CGSize? = nil
    private var frameWindow: CGRect? = nil
    private var titleWindow: TitleWindow?
    private var titleHeight: CGFloat = 30
    
    private var manager: FloatWindowManager = FloatWindowManager.instance
    private var actionsFloatWindow: FloatWindowsActions?
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        self.frameWindow = frame
        self.initialization()
    }
    
    override init() {
        super.init()
        initialization()
    }
    
    convenience init(sizeWindow: CGSize ) {
        self.init()
        self.sizeWindow = sizeWindow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        setHierarchyVisualization()
    }
    
    
//  MARK: - GET Properties
    var superView: UIView {
        if let superView = self._superView {
            return superView
        }
        return self.view.superview ?? UIView()
    }
    
    
    //  MARK: - LIFE CIRCLE
    func loadView() {}
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
    
    
//  MARK: - SET Properties
    
    @discardableResult
    func setTitleWindow(_ titleWindow: UIView ) -> Self {
        self.titleWindow = TitleWindow().setTitleView(titleWindow)
        return self
    }
    
    @discardableResult
    func setTitleHeight(_ height: CGFloat) -> Self {
        self.titleHeight = height
        return self
    }
    
    @discardableResult
    func setSizeWindow(_ sizeWindow: CGSize) -> Self {
        self.sizeWindow = sizeWindow
        return self
    }
    
    @discardableResult
    func setFrameWindow(_ frame: CGRect) -> Self {
        self.frameWindow  = frame
        return self
    }
    
//    @discardableResult
//    func setActions(_ action: (_ build: Self) -> Self ) -> Self {
//        _ = action(FloatWindowsActions(self))
//        return self
//    }
    
    
//  MARK: - Actions
    var bringToFront: Void {
        superView.bringSubviewToFront(self.view)
    }
    var minimize: Void { return }
    var maximize: Void { return }
    var restore: Void { return }
    
    
    
//  MARK: - PRESENT and DISMISS FloatWindow
    func present(insideTo: UIView) {
        self._superView = insideTo
        addCountWindows()
        loadView()
        viewDidLoad()
        configFloatWindow()
        viewWillAppear()
        addFloatWindow()
        appearFloatWindow()
        viewDidAppear()
    }
    
    func dismiss() {
        viewWillDisappear()
        removeWindows()
        viewDidDisappear()
    }
    
    
//  MARK: - PRIVATE Function Area
    
    private func removeWindows() {
        manager.removeCountWindow(self)
        self.view.removeFromSuperview()
    }
    
    private func addCountWindows() {
        manager.addCountWindow(self)
    }
    
    private func setHierarchyVisualization() {
        self.view.layer.zPosition = hierarchy
    }
    
    private func configFloatWindow() {
        decidePositionWindow()
        addFloatWindow()
        configTitleWindowView()
    }
    
    private func addFloatWindow() {
        self.view.add(insideTo: superView)
    }
   
    private func decidePositionWindow() {
        if let frameWindow {
            configFrameWindow(frameWindow)
            return
        }
        
        if let sizeWindow {
            configSizeWindow(sizeWindow)
            return
        }
        
        configAutoPositionWindow()
    }
    
    private func configAutoPositionWindow() {
        self.view.frame = CGRect(x: 50, y: 100, width: 200, height: 350)
    }
    
    private func appearFloatWindow() {
        self.view.isHidden = false
        titleWindow?.isShow = true
    }
    
    private func configSizeWindow(_ sizeWindow: CGSize) {
        self.view.frame = CGRect(x: 50, y: 100, width: sizeWindow.width, height: sizeWindow.height)
    }
    
    private func calculatePositionWindow() -> CGRect {
        return CGRect()
    }
    
    private func configFrameWindow(_ frame: CGRect) {
        self.view.frame = frame
    }
    
    private func configTitleWindowView() {
        if let titleWindow {
            addTitleWindow(titleWindow)
            configTitleWindowConstraints(titleWindow)
        }
    }
    
    private func addTitleWindow(_ titleWindow: UIView) {
        titleWindow.add(insideTo: self.view)
    }
    
    private func configTitleWindowConstraints(_ titleWindow: UIView) {
        titleWindow.makeConstraints({ make in
            make
                .setPinTop.equalToSuperView
                .setHeight.equalToConstant(titleHeight)
        })
    }
    
    
}
