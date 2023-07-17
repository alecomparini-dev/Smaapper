//
//  WhatBeerFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/07/23.
//

import UIKit
import Vision

class WhatBeerFloatViewController: FloatViewController {
    static let identifierApp = K.WhatBeer.identifierApp
    
    private var showResult: ShowResultPredictionViewController?
    
    lazy var screen: WhatBeerView = {
        let view = WhatBeerView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEnabledDraggable(true)
        setFrameWindow(CGRect(x: K.WhatBeer.FloatView.x,
                              y: K.WhatBeer.FloatView.y,
                              width: K.WhatBeer.FloatView.width ,
                              height: K.WhatBeer.FloatView.height))
        configDelegate()
    }
    
    override func viewDidSelectFloatView() {
        super.viewDidSelectFloatView()
        UtilsFloatView.setShadowActiveFloatView(screen)
        screen.cameraARKit.runSceneView()
    }
    
    override func viewDidDeselectFloatView() {
        super.viewDidDeselectFloatView()
        UtilsFloatView.removeShadowActiveFloatView(screen)
        screen.cameraARKit.pauseSceneView()
    }
    
    
    //  MARK: - PRIVATE Area
    
    private func configDelegate() {
        screen.delegate = self
    }
    
    private func processCapture() throws {
        let beerModel: VNCoreMLModel = try loadBeerModel()
        let snapShot: UIImage = try captureImage()
        let ciImage: CIImage = try convertToCIImage(snapShot)
        let requestHandler: VNImageRequestHandler = createRequestHandler(ciImage: ciImage)
        let request: VNCoreMLRequest = createRequestModel(beerModel)
        try performModel(requestHander: requestHandler, request: request )
    }
    
    private func performModel(requestHander: VNImageRequestHandler, request: VNCoreMLRequest ) throws {
        try requestHander.perform([request])
    }
    
    private func createRequestHandler(ciImage: CIImage) -> VNImageRequestHandler {
        return VNImageRequestHandler(ciImage: ciImage)
    }
    
    private func captureImage() throws -> UIImage {
        if let imageCam = screen.cameraARKit.getPrint() {
            return imageCam
        }
        throw CoreMLError.convertToCIImage(error: "Unable to capture image.")
    }
    
    private func convertToCIImage(_ image: UIImage) throws -> CIImage {
        if let ciImage = CIImage(image: image){
            return ciImage
        }
        throw CoreMLError.convertToCIImage(error: "Unable to convert image to CIImage")
    }
    
    private func loadBeerModel() throws -> VNCoreMLModel {
        do {
            return try VNCoreMLModel(for: Beer(configuration: MLModelConfiguration()).model)
        } catch let error {
            throw CoreMLError.loadBeerModel(error: error.localizedDescription)
        }
    }
    
    private func createRequestModel(_ model: VNCoreMLModel) -> VNCoreMLRequest{
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let self else {return}
            if error != nil {
                print("Mensagem para retentar porque deu falha", error?.localizedDescription ?? "")
//                return
            }
            completionSuccessProcessImage(request)
        }
        return request
    }
    
    private func completionSuccessProcessImage(_ request: VNRequest) {
        var identifier:[String] = []
        if let results = request.results as? [VNClassificationObservation] {
            results.forEach { result in
                switch result.confidence {
                case 0.98...1.0:
                    identifier.append(result.identifier)
                case 0.95...0.979:
                    identifier.append(result.identifier)
                case 0.90...0.949:
                    identifier.append(result.identifier)
                case 0.80...0.899:
                    identifier.append(result.identifier)
                default:
                    break
                }
            }
        }
        
        if identifier.isEmpty {
            print("Nao identificado, tentar novamente")
            identifier.append("ERRO")
//            return
        }
        
        if identifier.count > 1 {
            print("criar fluxo para mais de um chop identificado")
            return
        }
    
        if let result = identifier.first {
            configShowResult(result)
        }
        
    }
    
    private func configShowResult(_ result: String) {
        createShowResult(result)
        animateTransitionWithCATransition()
    }
    
    private func createShowResult(_ result: String) {
        showResult = ShowResultPredictionViewController(result)
    }
    
    
    func animateTransitionWithCATransition() {
        guard let showResult else {return}
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromRight
        
        // Adicione a nova view à hierarquia antes da animação
        screen.showResult.setHidden(false)
        showResult.add(insideTo: screen.showResult.view)
        showResult.setConstraints { build in
            build
                .setPin.equalToSuperView(50)
                .apply()
        }
        screen.showResult.view.layer.add(transition, forKey: kCATransition)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.removeAnimate()
        }
    }

    
    
    func removeAnimate() {
        guard let showResult else {return}
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromLeft
        
        screen.showResult.view.layer.add(transition, forKey: kCATransition)
        
        showResult.view.removeFromSuperview()
        screen.showResult.setHidden(true)
        
    }

    
}

//  MARK: - EXTENSION WhatBeerViewDelegate

extension WhatBeerFloatViewController: WhatBeerViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }
    
    func captureTapped() {
        do {
            try processCapture()
        } catch let error {
            print(error.localizedDescription)
        }
        
        screen.cameraARKit.pauseSceneView()
    }
    
}
