//
//  ShowResultPredictionViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 17/07/23.
//

import UIKit

class ShowResultPredictionViewController: ViewBuilder {
    
    private let result: String
    
    lazy var showResultView: ShowResultPredictionView = {
        let view = ShowResultPredictionView(self.result)
        return view
    }()
    
    init(_ result: String) {
        self.result = result
        super.init()
        initialization()
        setBackgroundColor(.red.withAlphaComponent(0.5))
    }
    
    private func initialization() {
        configShowResultPredictionView()
        showResultView.beerLabel.setText(self.result)
    }
    
    private func configShowResultPredictionView() {
        self.view = showResultView
    }


//  MARK: - SET DELEGATE
    func setDelegate(_ delegate: ShowResultPredictionViewDelegate) {
        showResultView.delegate = delegate
    }
    
}
