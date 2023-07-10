//
//  FloatWindowViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 19/05/23.
//

import UIKit

class FloatViewController: BaseBuilder {
    
    private let _hierarchy: CGFloat = 1000
    private var _isShow = false
    private weak var _superView: UIView?
    
    private var sizeWindow: CGSize? = nil
    private var frameWindow: CGRect? = nil
    private var textFields: [UITextField] = []
    
    private(set) var id: UUID = UUID()
    private(set) var customAttribute: Any?
    private(set) var isMinimized: Bool = false
    private(set) var originalCenter: CGPoint = .zero
    private(set) var active: Bool = false
    
    private unowned var manager: FloatViewControllerManager = FloatViewControllerManager.instance
    private var _actions: FloatViewControllerActions?
    
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
        viewDidAppear()
        select
    }
    
    func dismiss() {
        deselect
        viewWillDisappear()
        removeWindowAnimation(callBackViewWillDisappear)
    }
    
    private func callBackViewWillDisappear() {
        viewDidDisappear()
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
        manager.addFloatView(self)
        configTouchForActivateWindow()
        manager.enableDeactivationFloatViewWhenTappedSuperview(superView)
        manager.delegate?.viewDidLoad(self)
    }

    func viewWillAppear() {
        manager.delegate?.viewWillAppear(self)
    }
    

    func viewWillLayoutSubviews() {
        manager.delegate?.viewWillLayoutSubviews(self)
    }
    
    func viewDidLayoutSubviews(){
        manager.delegate?.viewDidLayoutSubviews(self)
    }
    
    func viewDidAppear() {
        setPositionFloatView()
        self.view.isHidden = false
        manager.delegate?.viewDidAppear(self)
    }
    
    
//  MARK: - DRAGGING
    func viewWillDrag() {
        manager.delegate?.viewWillDrag(self)
    }
    
    func viewDragging() {
        manager.delegate?.viewDragging(self)
    }
    
    func viewDidDrag(){
        setPositionFloatView()
        manager.delegate?.viewDidDrag(self)
    }

    
//  MARK: - ACTIVE / DEACTIVE

    func viewShouldSelectFloatView() {
        manager.delegate?.viewShouldSelectFloatView(self)
    }
    
    func viewDidSelectFloatView() {
        configRepositionFloatViewWhenShowKeyboard()
        manager.delegate?.viewDidSelectFloatView(self)
    }
    
    func viewDidDeselectFloatView() {
        unregisterKeyboardNotifications()
        manager.delegate?.viewDidDeselectFloatView(self)
    }
    
    
//  MARK: - MINIMIZE AND RESTORED
    
    func viewMinimize() {
        viewWillMinimize()
    }
    
    func viewWillMinimize() {
        setPositionFloatView()
        manager.delegate?.viewWillMinimize(self)
    }
    
    func viewDidMinimize() {
        view.isHidden = true
        isMinimized = true
        manager.removeDeactivationFloatViewWhenTappedSuperview()
        manager.delegate?.viewDidMinimize(self)
    }
    
    func viewWillRestore() {
        view.isHidden = false
        manager.delegate?.viewWillRestore(self)
    }

    func viewDidRestore() {
        isMinimized = false
        manager.enableDeactivationFloatViewWhenTappedSuperview(superView)
        manager.delegate?.viewDidRestore(self)
    }
    

//  MARK: - Disappear Window
    func viewWillDisappear() {
        manager.delegate?.viewWillDisappear(self)
    }

    func viewDidDisappear() {
        removeFloatView()
        manager.delegate?.viewDidDisappear(self)
        manager.verifyAllClosedWindows()
        manager.removeDeactivationFloatViewWhenTappedSuperview()
    }
    
    
//  MARK: - SET Properties
    
    @discardableResult
    func setEnabledDraggable(_ enabled: Bool) -> Self {
        setActions { build in
            build
                .setDraggable { build in
                    build
                        .setBeganDragging {[weak self] draggable in
                            guard let self else {return}
                            viewWillDrag()
                            select
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
    func setCustomAttribute(_ attribute: Any) -> Self {
        self.customAttribute = attribute
        return self
    }
    
    @discardableResult
    func setActions(_ action: (_ build: FloatViewControllerActions) -> FloatViewControllerActions ) -> Self {
        if let actions = self._actions {
            self._actions = action(actions)
            return self
        }
        self._actions = action(FloatViewControllerActions(self))
        return self
    }
    
    
//  MARK: - Actions

    var bringToFront: Void {
        superView.bringSubviewToFront(self.view)
    }

    var minimize: Void {
        if isMinimized {return}
        deselect
        viewWillMinimize()
        minimizeAnimation { [weak self] in
            guard let self else {return}
            viewDidMinimize()
        }
    }
    
    var restore: Void {
        if !isMinimized {return}
        select
        viewWillRestore()
        bringToFront
        restoreAnimation { [weak self] in
            self?.viewDidRestore()
        }
    }
    
    var select: Void {
        if active { return }
        manager.floatViewSelected()?.deselect
        viewShouldSelectFloatView()
        bringToFront
        active = true
        viewDidSelectFloatView()
    }
    
    var deselect: Void {
        if !active {return}
        self.view.endEditing(false)
        active = false
        viewDidDeselectFloatView()
    }
    
    
//  MARK: - PRIVATE Function Area
    
    private func setPositionFloatView() {
        originalCenter = self.view.center
    }
    
    private func removeFloatView() {
        manager.removeWindowToManager(self)
        self.view.removeFromSuperview()
        _actions = nil
        _superView = nil
    }
        
    private func setHierarchyVisualization() {
        self.view.layer.zPosition = _hierarchy
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
        self.view.frame = CGRect(x: 50, y: 100, width: 200, height: 380)
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
    
    private func configTouchForActivateWindow() {
        self.setActions { build in
            build
                .setTouch({ [weak self] _,_  in
                    guard let self else {return}
                    select
                }, false)
        }
    }
    
    private func configSetProperties() {
        decidePositionWindow()
    }

    
//  MARK: - CONTROL REPOSITION FLOATWINDOW
    
    private func configRepositionFloatViewIfNeeded(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let constantVisibility = 25.0
        if let textFieldAbsolutePosition = calculateAbsolutePositionTextField() {
            let textFieldPositionWithIncreasedVisibility = textFieldAbsolutePosition + constantVisibility
            
            let keyboardPosition = keyboardFrame.origin.y
            if textFieldPositionWithIncreasedVisibility <= keyboardPosition { return }
            
            let floatViewPositionY = self.view.frame.minY
            let finalPosition = keyboardPosition - (textFieldPositionWithIncreasedVisibility - floatViewPositionY)
            repositionFloatViewShowKeyboardAnimation(finalPosition)
        }
    }
    
    private func calculateAbsolutePositionTextField() -> CGFloat? {
        if let textFieldActive = getTextFieldActive() {
            return textFieldActive.convert(textFieldActive.bounds, to: nil).maxY
        }
        return nil
    }
    
    private func getTextFieldActive() -> UITextField? {
        return self.textFields.first { $0.isFirstResponder }
    }
    
    private func repositionFloatViewHideKeyboard() {
        view.center = originalCenter
    }
    
    
//  MARK: - KEYBOARD
    private func configRepositionFloatViewWhenShowKeyboard() {
        self.textFields = Utils.TextField.allTextFieldsInView(self.view)
        if textFields.count > 0 {
            registerKeyboardNotifications()
        }
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    

    
    
//  MARK: - OBJC Area
    @objc func keyboardWillShow(_ notification: Notification) {
        configRepositionFloatViewIfNeeded(notification)
    }
    
    @objc func keyboardWillHide() {
        viewWillLayoutSubviews()
        repositionFloatViewHideKeyboard()
        viewDidLayoutSubviews()
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
    
    private func repositionFloatViewShowKeyboardAnimation(_ finalPosition: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0 , options: .curveEaseInOut, animations: { [weak self] in
            guard let self else {return}
            viewWillLayoutSubviews()
            view.frame.origin = CGPoint(x: view.frame.origin.x, y: finalPosition)
        }, completion: { [weak self] _ in
            guard let self else {return}
            viewDidLayoutSubviews()
        })
    }
    
}
