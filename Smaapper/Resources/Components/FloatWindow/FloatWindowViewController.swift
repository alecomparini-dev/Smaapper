//
//  FloatWindowViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 19/05/23.
//

import UIKit


class FloatWindowViewController: BaseBuilder {
    
    private let hierarchy: CGFloat = 1000
    private var _isShow = false
    private var alreadyApplied = false
    private var _superView: UIView?
    
    private var sizeWindow: CGSize? = nil
    private var frameWindow: CGRect? = nil
    private var titleWindow: TitleWindow?
    private var titleHeight: CGFloat = 30
    
    private(set) var id: UUID = UUID()
    private(set) var customAttribute: Any?
    
    private(set) var isMinimized: Bool = false
    private(set) var originalCenter: CGPoint = .zero
    
    private var manager: FloatWindowManager = FloatWindowManager.instance
    private var actions: FloatWindowsActions?
    
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
        print(#function, #fileID)
        self._superView = insideTo
        loadView()
        viewDidLoad()
        configSetProperties()
        viewWillAppear()
        viewWillLayoutSubviews()
        viewDidLayoutSubviews()
        viewDidAppear()
    }

    func dismiss() {
        print(#function, #fileID)
        viewWillDisappear()
    }
        
    
//  MARK: - GET Properties
    var superView: UIView {
        if let superView = self._superView {
            return superView
        }
        return self.view.superview ?? UIView()
    }
    
    
//  MARK: - LIFE CIRCLE
    func loadView() {
        print(#function, #fileID)
    }
    
    func viewDidLoad() {
        print(#function, #fileID)
        addFloatWindow()
        setHierarchyVisualization()
        addWindowsToManager()
        configTouchForActivateWindow()
        manager.configDesactivateWindowWhenTappedSuperView(superView)
        manager.delegate?.viewDidLoad(self)
    }

    
    func viewWillAppear() {
        print(#function, #fileID)
        manager.delegate?.viewWillAppear(self)
        viewActivated()
    }
    
    func viewWillLayoutSubviews(){
        print(#function, #fileID)
        manager.delegate?.viewWillLayoutSubviews(self)
    }
    
    func viewDidLayoutSubviews(){
        print(#function, #fileID)
        manager.delegate?.viewDidLayoutSubviews(self)
    }
    
    func viewDidAppear() {
        print(#function, #fileID)
        self.view.isHidden = false
        manager.delegate?.viewDidAppear(self)
    }
    
    
//  MARK: - Dragging
    func viewWillDragging() {
        print(#function, #fileID)
        manager.delegate?.viewWillDragging(self)
        viewActivated()
    }
    
    func viewDragging() {
        manager.delegate?.viewDragging(self)
    }
    
    func viewEndedDragging(){
        print(#function, #fileID)
        manager.delegate?.viewEndedDragging(self)
    }

//  MARK: - Functions Min-Res-Act-Deac
    func viewMinimized() {
        print(#function, #fileID)
        minimizeAnimation(callBackViewMinimized)
        manager.lastActiveWindow?.viewActivated()
    }
    private func callBackViewMinimized() {
        view.isHidden = true
        manager.delegate?.viewMinimized(self)
        viewDesactivated()
    }
    
    func viewRestored() {
        print(#function, #fileID)
        manager.delegate?.viewRestored(self)
        viewWillAppear()
        viewDidAppear()
    }
    
    func viewActivated() {
        print(#function, #fileID)
        if manager.isActivate(self) {return}
        if isMinimized {return}
        self.bringToFront
        manager.activeWindow = self
        manager.delegate?.viewActivated(self)
    }
    
    func viewDesactivated() {
        print(#function, #fileID)
        manager.deactiveWindow(self)
        manager.delegate?.viewDesactivated(self)
    }
    
    
//  MARK: - Disappear Window
    func viewWillDisappear() {
        print(#function, #fileID)
        removeWindowAnimation()
    }
    
    func viewDidDisappear() {
        print(#function, #fileID)
        removeWindowToManager()
        removeWindowToSuperview()
        manager.verifyAllClosedWindows()
    }
    
    
//  MARK: - SET Properties
    
    @discardableResult
    func setTitleWindow(_ titleWindow: UIView ) -> Self {
        self.titleWindow = TitleWindow().setTitleView(titleWindow)
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
                            self.viewWillDragging()
                        }
                        .setDragging { [weak self] draggable in
                            guard let self else {return}
                            self.viewDragging()
                        }
                        .setDropped { [weak self] draggable in
                            guard let self else {return}
                            self.viewEndedDragging()
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
    func setActions(_ action: (_ build: FloatWindowsActions) -> FloatWindowsActions ) -> Self {
        if let actions = self.actions {
            self.actions = action(actions)
            return self
        }
        self.actions = action(FloatWindowsActions(self))
        return self
    }
    
    @discardableResult
    func setCustomAttribute(_ attribute: Any) -> Self {
        self.customAttribute = attribute
        return self
    }
    
    
//  MARK: - Actions
    var bringToFront: Void {
        print(#function, #fileID)
        superView.bringSubviewToFront(self.view)
    }
    
    var minimize: Void {
        print(#function, #fileID)
        if isMinimized {return}
        isMinimized = true
        originalCenter = self.view.center
        viewMinimized()
    }
    
    var restore: Void {
        print(#function, #fileID)
        isMinimized = false
        restoreAnimation()
        return
    }
    
    var maximize: Void { return }
    
    
    

    
//  MARK: - PRIVATE Function Area
    
    private func addWindowsToManager() {
        print(#function, #fileID)
        manager.addWindowToManager(self)
    }
    
    private func removeWindowToManager() {
        manager.removeWindowToManager(self)
    }
    
    private func setHierarchyVisualization() {
        self.view.layer.zPosition = hierarchy
    }
    
    private func addFloatWindow() {
        print(#function, #fileID)
        self.view.add(insideTo: superView)
    }
   
    private func decidePositionWindow() {
        print(#function, #fileID)
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
        print(#function, #fileID)
        
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
        print(#function, #fileID)
        if let titleWindow {
            addTitleWindow(titleWindow)
            configTitleWindowConstraints(titleWindow)
            titleWindow.isShow = true
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
        print(#function, #fileID)
        self.setActions { build in
            build
                .setTapGesture { build in
                    build
                        .setCancelsTouchesInView(false)
                        .setTouchEnded { [weak self] tapGesture in
                            guard let self else {return}
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
    
    private func removeWindowAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0
        }, completion: { [weak self] _ in
            guard let self else {return}
            self.viewDidDisappear()
        })
    }
    
    
    private func minimizeAnimation(_ closure: @escaping () -> Void ) {
        print(#function, #fileID)
        UIView.animate(withDuration: 0.3, delay: 0 , options: .curveEaseInOut, animations: { [weak self] in
            guard let self else {return}
            view.alpha = 0.0
            view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            view.center = CGPoint(x: superView.center.x, y: superView.frame.maxY)
        }, completion: { _ in
            closure()
        })
    }
    
    
    private func restoreAnimation() {
        print(#function, #fileID)
        self.view.isHidden = false
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self else {return}
            view.alpha = 1
            view.transform = CGAffineTransform.identity
            view.center = self.originalCenter
        }, completion: { _ in
            self.viewRestored()
        })
    }
}
