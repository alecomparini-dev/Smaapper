//
//  HangmanFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/06/23.
//

import UIKit


class HangmanFloatViewController: FloatViewController {
    static let identifierApp = "hangman"
    
    private var chooseLetterOnKeyboard: HangmanKeyboardLetterView?
    private var lettersInWord: [HangmanLetterInWordView] = []
    
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
        screen.gallowsKeyboardView.delegate = self
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
        self.lastPlayedWord = "inovacao"
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
        let word = getCurrentWord()
        self.lettersInWord = screen.gallowsWordView.createWord(word.syllables.joined().uppercased())
        positionLetters()
        setTipLabel()
    }
    
    private func getCurrentWord() -> HangmanWord{
        return hangmanWord[currentIndexPlayedWord]
    }
    
    private func setTipLabel() {
        let tip = getCurrentWord().subject
        screen.tipDescriptionLabel.setText(tip)
    }
    
    private func isLastWordByIndex(_ index: Int) -> Bool {
        if currentIndexPlayedWord < hangmanWord.count {
            return false
        }
        return true
    }
    
    private func positionLetters() {
        let indexToBreakLine = calculateIndexToBreakLine()
        self.lettersInWord.enumerated().forEach { index,letter in
            if index < indexToBreakLine {
                addLetterStackHorizontal1(letter)
                return
            }
            addLetterStackHorizontal2(letter)
        }
    }
    
    private func addLetterStackHorizontal1(_ letter: HangmanLetterInWordView) {
        screen.gallowsWordView.insertLetterInStack(letter, screen.gallowsWordView.horizontalStack1)
    }
    
    private func addLetterStackHorizontal2(_ letter: HangmanLetterInWordView) {
        if screen.gallowsWordView.horizontalStack2.view.isHidden {
            screen.gallowsWordView.horizontalStack2.setHidden(false)
        }
        screen.gallowsWordView.insertLetterInStack(letter, screen.gallowsWordView.horizontalStack2)
    }
    
    private func calculateIndexToBreakLine() -> Int {
        if getCurrentWord().word.count <= quantityLetterByLine {return quantityLetterByLine}
        let syllabesWord = getCurrentWord().syllables
        let indexToBreakLine = syllabesWord.reduce(0) { partialResult, syllabe in
            let result = partialResult + syllabe.count
            guard result <= quantityLetterByLine else {
                return partialResult
            }
            return result
        }
        return indexToBreakLine
    }
    
    private func verifyMatchToGallowsWord(_ letter: String) -> [Int] {
        let currentWord = getCurrentWord().syllables.joined().folding(options: .diacriticInsensitive, locale: nil)
        let indices = currentWord.enumerated().compactMap { index,char in
            return (char == Character(letter.lowercased())) ? index : nil
        }
        return indices
    }
    
    private func updateGame() {
        guard let chooseLetterOnKeyboard else {return}
        if chooseLetterOnKeyboard.buttonInteration?.isPressed ?? true {return}
        let indexMatch: [Int] = verifyMatchToGallowsWord(chooseLetterOnKeyboard.text)
        updateLetterOnKeyboard(indexMatch)
        revealLetterInWordIfExists(indexMatch)
    }
    
    private func updateLetterOnKeyboard(_ indexMatch: [Int]) {
        if indexMatch.isEmpty {
            updateLetterError()
            return
        }
        updateLetterSuccess()
    }
    
    private func updateLetterSuccess() {
        removeNeumorphismLetter()
        configStyleButtonPressed(15, Theme.shared.currentTheme.surfaceContainerHighest)
        pressedButtonLetter()
    }
    
    private func updateLetterError() {
        removeNeumorphismLetter()
        setShadowColorError()
        configStyleButtonPressed(15, Theme.shared.currentTheme.surfaceContainer)
        pressedButtonLetter()
    }
    
    private func pressedButtonLetter() {
        chooseLetterOnKeyboard?.buttonInteration?.pressed
        chooseLetterOnKeyboard?.buttonInteration?.setEnabledInteraction(true)
    }
    
    private func configStyleButtonPressed(_ cornerRadius: CGFloat, _ color: UIColor) {
        chooseLetterOnKeyboard?.gallowsLetter.outlineView.border?.setCornerRadius(cornerRadius)
        chooseLetterOnKeyboard?.gallowsLetter.outlineView.setBackgroundColorLayer(color)
    }
    
    private func removeNeumorphismLetter() {
        chooseLetterOnKeyboard?.gallowsLetter.outlineView.neumorphism?.removeNeumorphism()
    }
    
    private func setShadowColorError() {
        chooseLetterOnKeyboard?.buttonInteration?.setColor(Theme.shared.currentTheme.error)
    }
    
    private func revealLetterInWordIfExists(_ indexMatch: [Int]) {
        indexMatch.forEach { index in
            screen.gallowsWordView.revealLetterInWord(lettersInWord[index])
        }
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


//  MARK: - EXTENSION GallowsKeyboardViewDelegate
extension HangmanFloatViewController: HangmanKeyboardViewDelegate {
    
    func letterKeyboardTapped(_ letter: HangmanKeyboardLetterView) {
        self.chooseLetterOnKeyboard = letter
        updateGame()
    }
    
    
}

