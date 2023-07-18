//
//  ShowResultPredictionViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 17/07/23.
//

import UIKit

class ShowResultBeerViewController: ViewBuilder {
    
    private let result: String
    
    lazy var showResultView: ShowResultBeerView = {
        let view = ShowResultBeerView(self.result)
        return view
    }()
    
    init(_ result: String) {
        self.result = result
        super.init()
        initialization()
    }
    
    private func initialization() {
        configShowResultBeerView()
        showResultView.beerLabel.setText(self.result)
    }
    
    private func configShowResultBeerView() {
        self.view = showResultView
    }   


//  MARK: - SET DELEGATE
    func setDelegate(_ delegate: ShowResultBeerViewDelegate) {
        showResultView.delegate = delegate
    }
    
}
