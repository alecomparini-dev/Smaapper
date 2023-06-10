//
//  FloatWindowViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 19/05/23.
//

import UIKit


class FloatViewController: BaseBuilder {
    
    private let hierarchy: CGFloat = 1000
    private var _isShow = false
    private var alreadyApplied = false
    private var _superView: UIView?
    
    private var sizeWindow: CGSize? = nil
    private var frameWindow: CGRect? = nil
    private var titleWindow: TitleFloatView?
    private var titleHeight: CGFloat = 30
    
    
    private(set) var id: UUID = UUID()
    private(set) var customAttribute: Any?
    private(set) var active: Bool = false
    private(set) var lastActive: Bool = false
    
    private(set) var isMinimized: Bool = false
    private(set) var originalCenter: CGPoint = .zero
    
    private var manager: FloatManager = FloatManager.instance
    private var actions: FloatViewControllerActions?
    
    private var _view: View = View()
    var view: View {
        get { self._view }
        set {
            self._view = newValue
            super.component = self._view
        }
    }
    
    init(frame: CGRect ) {
        super.init(self._view)
        self.frameWindow = frame
    }
    
    init() {
        super.init(self._view)
    }
    
    convenience init(sizeWindow: CGSize ) {
        self.init()
        self.sizeWindow = sizeWindow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - PRESENT and DISMISS FloatWindow
    func present(insideTo: UIView) {
        self._superView = insideTo
        loadView()
        viewDidLoad()
        configSetProperties()
        viewWillAppear()
        viewWillLayoutSubviews()
        viewDidLayoutSubviews()
        manager.windowActive()?.viewDesactivated()
        viewActivated()
        viewDidAppear()
    }
    
    
    func dismiss() {
        viewWillDisappear()
        viewDesactivated()
        manager.lastWindowActive()?.viewActivated()
        manager.windowActive()?.bringToFront
    }
        
    
//  MARK: - GET Properties
    var superView: UIView {
        return self._superView ?? UIView()
    }
    
    
//  MARK: - LIFE CIRCLE
    func loadView() { }
    
    func viewDidLoad() {
        addFloatWindow()
        setHierarchyVisualization()
        addWindowsToManager()
        configTouchForActivateWindow()
        manager.configDesactivateWindowWhenTappedSuperView(superView)
        manager.delegate?.viewDidLoad(self)
    }

    func viewWillAppear() {
        manager.delegate?.viewWillAppear(self)
    }
    
    func viewWillLayoutSubviews(){
        manager.delegate?.viewWillLayoutSubviews(self)
    }
    
    func viewDidLayoutSubviews(){
        manager.delegate?.viewDidLayoutSubviews(self)
    }
    
    func viewDidAppear() {
        self.view.isHidden = false
        manager.delegate?.viewDidAppear(self)
    }
    
    
//  MARK: - Dragging
    func viewWillDrag() {
        manager.delegate?.viewWillDrag(self)
    }
    
    func viewDragging() {
        manager.delegate?.viewDragging(self)
    }
    
    func viewDidDrag(){
        manager.delegate?.viewDidDrag(self)
    }


    
//  MARK: - ACTIVE / DEACTIVE

    func viewActivated() {
        if isMinimized {return}
        if active {return}
        active = true
        lastActive = false
        manager.delegate?.viewActivated(self)
    }
    
    func viewDesactivated() {
        active = false
        lastActive = true
        manager.delegate?.viewDesactivated(self)
    }
    
    
    
//  MARK: - MINIMIZE AND RESTORED
    
    func viewMinimize() {
        viewWillMinimize()
    }
    
    func viewWillMinimize() {
        isMinimized = true
        originalCenter = self.view.center
        minimizeAnimation(callBackViewMinimized)
        manager.delegate?.viewWillMinimize(self)
    }
    
    private func callBackViewMinimized() {
        viewDidMinimize()
    }
    
    func viewDidMinimize() {
        view.isHidden = true
        manager.delegate?.viewDidMinimize(self)
    }
    
    func viewRestore() {
        viewWillRestore()
    }
    
    func viewWillRestore() {
        isMinimized = false
        manager.delegate?.viewWillRestore(self)
        view.isHidden = false
        restoreAnimation(callBackViewRestored)
    }
    private func callBackViewRestored() {
        viewDidRestore()
    }
    
    func viewDidRestore() {
        self.bringToFront
        manager.delegate?.viewDidRestore(self)
    }
    

//  MARK: - Disappear Window
    func viewWillDisappear() {
        removeWindowToManager()
        manager.delegate?.viewWillDisappear(self)
        removeWindowAnimation(callBackViewWillDisappear)
    }
    private func callBackViewWillDisappear() {
        viewDidDisappear()
    }
    
    func viewDidDisappear() {
        removeWindowToSuperview()
        manager.delegate?.viewDidDisappear(self)
        manager.verifyAllClosedWindows()
    }
    
    
//  MARK: - SET Properties
    
    @discardableResult
    func setTitleWindow(_ titleWindow: UIView ) -> Self {
        self.titleWindow = TitleFloatView().setTitleView(titleWindow)
        self.view.bringSubviewToFront(titleWindow)
        return self
    }
    
    @discardableResult
    func setEnabledDraggable(_ enabled: Bool) -> Self {
        setActions { build in
            build
                .setDraggable { build in
                    build
                        .setBeganDragging {[weak self] draggable in
                            guard let self else {return}
                            if active {return}
                            self.bringToFront
                            manager.windowActive()?.viewDesactivated()
                            viewActivated()
                            viewWillDrag()
                        }
                        .setDragging { [weak self] draggable in
                            guard let self else {return}
                            self.viewDragging()
                        }
                        .setDropped { [weak self] draggable in
                            guard let self else {return}
                            self.viewDidDrag()
                        }
                }
        }
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
        self.frameWindow = frame
        return self
    }
    
    @discardableResult
    func setActions(_ action: (_ build: FloatViewControllerActions) -> FloatViewControllerActions ) -> Self {
        if let actions = self.actions {
            self.actions = action(actions)
            return self
        }
        self.actions = action(FloatViewControllerActions(self))
        return self
    }
    
    @discardableResult
    func setCustomAttribute(_ attribute: Any) -> Self {
        self.customAttribute = attribute
        return self
    }
    
    
//  MARK: - Actions
    var bringToFront: Void {
        superView.bringSubviewToFront(self.view)
    }

    var minimize: Void {
        manager.lastWindowActive()?.viewActivated()
        viewDesactivated()
        viewMinimize()
    }
    
    var restore: Void {
        viewRestore()
        manager.windowActive()?.viewDesactivated()
        viewActivated()
        bringToFront
    }
    
    var select: Void {
        self.bringToFront
        manager.windowActive()?.viewDesactivated()
        viewActivated()
    }
    
    
//  MARK: - PRIVATE Function Area
    
    private func addWindowsToManager() {
        manager.addWindowToManager(self)
    }
    
    private func removeWindowToManager() {
        manager.removeWindowToManager(self)
    }
    
    private func setHierarchyVisualization() {
        self.view.layer.zPosition = hierarchy
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
            titleWindow.isShow = true
            titleWindow.isUserInteractionEnabled = true
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
    
    private func configTouchForActivateWindow() {
        self.setActions { build in
            build
                .setTapGesture { build in
                    build
                        .setCancelsTouchesInView(false)
                        .setTouchEnded { [weak self] tapGesture in
                            guard let self else {return}
                            if active {return}
                            self.bringToFront
                            manager.windowActive()?.viewDesactivated()
                            viewActivated()
                        }
                }
        }
        
    }
    
    private func configSetProperties() {
        configTitleWindowView()
        decidePositionWindow()
    }

    private func removeWindowToSuperview() {
        self.view.removeFromSuperview()
    }
    
    
//  MARK: - ANIMATIONS
    
    private func removeWindowAnimation(_ closure: @escaping () -> Void ) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0
        }, completion: { _ in
            closure()
        })
    }
    
    
    private func minimizeAnimation(_ closure: @escaping () -> Void ) {
        UIView.animate(withDuration: 0.3, delay: 0 , options: .curveEaseInOut, animations: { [weak self] in
            guard let self else {return}
            view.alpha = 0.0
            view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            view.center = CGPoint(x: superView.center.x, y: superView.frame.maxY)
        }, completion: { _ in
            closure()
        })
    }
    
    
    private func restoreAnimation(_ closure: @escaping () -> Void ) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self else {return}
            view.alpha = 1
            view.transform = CGAffineTransform.identity
            view.center = self.originalCenter
        }, completion: { _ in
            closure()
        })
    }
}
