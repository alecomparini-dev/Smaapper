//
//  StickyNoteFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 03/07/23.
//

import UIKit

class StickyNoteFloatViewController: FloatViewController {
    static let identifierApp = K.Sticky.identifierApp
    
    lazy var screen: StickyNoteView = {
        let view = StickyNoteView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEnabledDraggable(true)
        setFrameWindow(CGRect(x: 20, y: 50, width: (Utils.currentWindow?.screen.bounds.width ?? 300)-40 , height: 500))
        configDelegate()
    }
    
    override func viewDidSelectFloatView() {
        super.viewDidSelectFloatView()
        UtilsFloatView.setShadowActiveFloatView(screen)
    }
    
    override func viewDidDeselectFloatView() {
        super.viewDidDeselectFloatView()
        UtilsFloatView.removeShadowActiveFloatView(screen)
    }
    

//  MARK: - PRIVATE Area
    
    private func configDelegate() {
        screen.delegate = self
    }
    
}

//  MARK: - EXTENSION TapeMeasureViewDelegate

extension StickyNoteFloatViewController: StickyNoteViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }
    
}
