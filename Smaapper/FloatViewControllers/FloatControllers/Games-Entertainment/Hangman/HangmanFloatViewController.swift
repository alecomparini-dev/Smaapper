//
//  HangmanFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/06/23.
//

import UIKit


class HangmanFloatViewController: FloatViewController {
    static let identifierApp = "hangman"
    
    private let errorCountToEndGame = 6
    private var chosenLetterFromKeyboard: HangmanKeyboardLetterView?
    private var lettersInWord: [HangmanLetterInWordView] = []
    private var indexMatchInWord: [Int] = []
    private var errorLetters: Int = 0
    private var successLetterIndex: [Int] = []
    private var isEndGame: Bool = false
    
    private var lastPlayedWord: String = "sagacidade"
    private let quantityLetterByLine = 10
    private let viewModel: HangmanViewModel = HangmanViewModel()
    private var hangmanWord: [HangmanWord] = []
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
    
    private func verifyMatchToGallowsWord(_ letter: String) {
        let currentWord = getCurrentWord().syllables.joined().folding(options: .diacriticInsensitive, locale: nil)
        self.indexMatchInWord = currentWord.enumerated().compactMap { index,char in
            return (char == Character(letter.lowercased())) ? index : nil
        }
    }
    
    private func updateGame() {
        guard let chosenLetterFromKeyboard else {return}
        if chosenLetterFromKeyboard.buttonInteration?.isPressed ?? true {return}
        verifyMatchToGallowsWord(chosenLetterFromKeyboard.text)
        updateLetterOnKeyboard()
        revealLetterInWordIfExists()
        revealGallowsDoll()
    }
    
    private func revealGallowsDoll() {
        if isChoseCorrectly() {return}
        revealBodyPart()
    }
    
    private func revealBodyPart() {
        
        switch errorLetters {
            case 1:
                screen.gallowsView.gallowsDollView.firstError()
            
            case 2:
                screen.gallowsView.gallowsDollView.secondError()
            
            case 3:
                screen.gallowsView.gallowsDollView.thirdError()
            
            case 4:
                screen.gallowsView.gallowsDollView.fourthError()
            
            case 5:
                screen.gallowsView.gallowsDollView.fifthError()
            
            case 6:
                screen.gallowsView.gallowsDollView.sixthError()
            
            default:
                break
        }
    }
    
    private func updateLetterOnKeyboard() {
        if !isChoseCorrectly() {
            updateLetterError()
            return
        }
        updateLetterSuccess()
    }
    
    private func isChoseCorrectly() -> Bool {
        if indexMatchInWord.isEmpty {return false}
        return true
    }
    
    private func updateLetterSuccess() {
        removeNeumorphismLetter()
        configStyleButtonPressed(15, Theme.shared.currentTheme.surfaceContainerHighest)
        pressedButtonLetter()
    }
    
    private func updateLetterError() {
        incrementErrorCount()
        removeNeumorphismLetter()
        setShadowColorError()
        configStyleButtonPressed(15, Theme.shared.currentTheme.surfaceContainer)
        pressedButtonLetter()
    }
    
    private func incrementErrorCount() {
        errorLetters += 1
        setEndGame()
    }
    
    private func incrementSuccessLetter(_ index: Int) {
        successLetterIndex.append(index)
        setEndGame()
    }
    
    private func setEndGame() {
        if errorLetters == errorCountToEndGame {
            configFailureEndGame()
            return isEndGame = true
        }
        if successLetterIndex.count == getCurrentWord().word.count {
            configSuccessEndGame()
            return isEndGame = true
        }
    }
    
    private func configFailureEndGame() {
        let colorError = Theme.shared.currentTheme.error
        screen.gallowsView.setColorGallows(colorError)
        screen.gallowsView.ropeGallows.neumorphism?.setReferenceColor(colorError).apply()
        screen.gallowsView.ropeCircleGallows.setTintColor(colorError)
        screen.gallowsView.gallowsDollView.showDollFailure()
    }
    
    private func configSuccessEndGame() {
        screen.gallowsView.ropeGallows.setHidden(true)
        screen.gallowsView.ropeCircleGallows.setHidden(true)
        screen.gallowsView.gallowsDollView.showDollSuccess()
    }
    
    private func pressedButtonLetter() {
        chosenLetterFromKeyboard?.buttonInteration?.pressed
        chosenLetterFromKeyboard?.buttonInteration?.setEnabledInteraction(true)
    }
    
    private func configStyleButtonPressed(_ cornerRadius: CGFloat, _ color: UIColor) {
        chosenLetterFromKeyboard?.gallowsLetter.outlineView.border?.setCornerRadius(cornerRadius)
        chosenLetterFromKeyboard?.gallowsLetter.outlineView.setBackgroundColorLayer(color)
    }
    
    private func removeNeumorphismLetter() {
        chosenLetterFromKeyboard?.gallowsLetter.outlineView.neumorphism?.removeNeumorphism()
    }
    
    private func setShadowColorError() {
        chosenLetterFromKeyboard?.buttonInteration?.setColor(Theme.shared.currentTheme.error)
    }
    
    private func revealLetterInWordIfExists() {
        var duration = 0.5
        self.indexMatchInWord.forEach { index in
            incrementSuccessLetter(index)
            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(duration)) {
                self.screen.gallowsWordView.revealLetterInWord(self.lettersInWord[index])
            }
            duration += 1
        }
    }

}


//  MARK: - EXTENSION HangmanViewDelegate
extension HangmanFloatViewController: HangmanViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }

}


//  MARK: - EXTENSION HangmanKeyboardViewDelegate
extension HangmanFloatViewController: HangmanKeyboardViewDelegate {
    
    func letterKeyboardTapped(_ letter: HangmanKeyboardLetterView) {
        if isEndGame {return}
        self.chosenLetterFromKeyboard = letter
        updateGame()
    }
    
    
}

