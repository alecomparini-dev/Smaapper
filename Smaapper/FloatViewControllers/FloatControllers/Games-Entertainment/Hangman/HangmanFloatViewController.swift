//
//  HangmanFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/06/23.
//

import UIKit


class HangmanFloatViewController: FloatViewController {
    static let identifierApp = "hangman"
    
    private let quantityLetterByLine = 10
    private let viewModel: HangmanViewModel = HangmanViewModel()
    private var hangmanWord: [HangmanWord] = []
    private var lastPlayedWord: String  = ""
    private var currentIndexPlayedWord: Int = -1
    
    lazy var screen: HangmanView = {
        let view = HangmanView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePositionFloatView()
        setEnabledDraggable(true)
        configDelegate()
        configInitialWord()
    }
    
    override func viewDidSelectFloatView() {
        super.viewDidSelectFloatView()
        setShadow()
    }
    
    override func viewDidDeselectFloatView() {
        super.viewDidDeselectFloatView()
        removeShadow()
    }
    
    
//  MARK: - PRIVATE Area
    
    private func configDelegate() {
        screen.delegate = self
    }
    
    private func setShadow() {
        UtilsFloatView.setShadowActiveFloatView(screen)
    }
    
    private func removeShadow() {
        UtilsFloatView.removeShadowActiveFloatView(screen)
    }
    
    private func calculatePositionFloatView() {
        var y: CGFloat = 30
        if #available(iOS 11.0, *) {
            let window = Utils.currentWindow
            if let topSafeAreaInset = window?.safeAreaInsets.top {
                y = topSafeAreaInset
            }
        }
        setFrameWindow(CGRect(x: 30, y: y, width: 290, height: 550))
    }
    
    private func configInitialWord() {
        getIndexOfLastPlayedWord()
    }
    
    private func getIndexOfLastPlayedWord() {
        // Implementar
        self.lastPlayedWord = ""
        fetchWords()
    }
    
    private func fetchWords() {
        viewModel.fetchWordsFromLastPlayedWordInJson(.file, self.lastPlayedWord) { [weak self] result, error in
            guard let self else {return}
            if error != nil {
                print(#function, #file, error?.localizedDescription ?? "")
                return
            }
            hangmanWord = result
            createNextWord()
        }
    }
    
    private func createNextWord() {
        if isLastWordByIndex(currentIndexPlayedWord) {return}
        currentIndexPlayedWord += 1
        let word = hangmanWord[currentIndexPlayedWord]
        let letters: [GallowsLetterInWordView] = screen.gallowsWordView.createWord(word.syllables.joined().uppercased())
        positionLetters(letters)
    }
    
    private func isLastWordByIndex(_ index: Int) -> Bool {
        if currentIndexPlayedWord < hangmanWord.count {
            return false
        }
        return true
    }
    
    private func positionLetters(_ letters: [GallowsLetterInWordView]) {
        let indexToBreakLine = calculateIndexToBreakLine()
        letters.enumerated().forEach { index,letter in
            if index < indexToBreakLine {
                addLetterStackHorizontal1(letter)
                return
            }
            addLetterStackHorizontal2(letter)
        }
    }
    
    private func addLetterStackHorizontal1(_ letter: GallowsLetterInWordView) {
        screen.gallowsWordView.insertLetterInStack(letter, screen.gallowsWordView.horizontalStack1)
    }
    
    private func addLetterStackHorizontal2(_ letter: GallowsLetterInWordView) {
        if screen.gallowsWordView.horizontalStack2.view.isHidden {
            screen.gallowsWordView.horizontalStack2.setHidden(false)
        }
        screen.gallowsWordView.insertLetterInStack(letter, screen.gallowsWordView.horizontalStack2)
    }
    
    
    private func calculateIndexToBreakLine() -> Int {
        if hangmanWord[currentIndexPlayedWord].word.count <= quantityLetterByLine {return quantityLetterByLine}
        let syllabesWord = hangmanWord[currentIndexPlayedWord].syllables
        let indexToBreakLine = syllabesWord.reduce(0) { partialResult, syllabe in
            let result = partialResult + syllabe.count
            guard result <= quantityLetterByLine else {
                return partialResult
            }
            return result
        }
        return indexToBreakLine
    }
    
}


//  MARK: - EXTENSIONWeatherViewDelegate

extension HangmanFloatViewController: HangmanViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }

    
}


