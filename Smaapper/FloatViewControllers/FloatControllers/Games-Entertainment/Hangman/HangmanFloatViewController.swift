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
    private var indexMatchInWordFromChosenLetter: [Int] = []
    private var errorLetters: Int = 0
    private var successLetterIndex: Set<Int> = []
    private var isEndGame: Bool = false
    
    private var lastPlayedWord: String = "arbitrio"
    private let quantityLetterByLine = 10
    private let viewModel: HangmanViewModel = HangmanViewModel()
    private var hangmanWords: [HangmanWord] = []
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
            hangmanWords = result
            createNextWord()
        }
    }
    
    private func createNextWord() {
        if isLastWord() { return }
        currentIndexPlayedWord += 1
        let word = getCurrentWord()
        self.lettersInWord = screen.gallowsWordView.createWord(word.syllables.joined().uppercased())
        positionLetters()
        setTipLabel()
    }
    
    private func getCurrentWord() -> HangmanWord{
        return hangmanWords[currentIndexPlayedWord]
    }
    
    private func setTipLabel() {
        let tip = getCurrentWord().subject
        screen.tipDescriptionLabel.setText(tip)
    }
    
    private func isLastWord() -> Bool {
        if currentIndexPlayedWord < (hangmanWords.count-1) {
            return false
        }
        print("end word - end game")
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
        self.indexMatchInWordFromChosenLetter = currentWord.enumerated().compactMap { index,char in
            return (char == Character(letter.lowercased())) ? index : nil
        }
        incrementSuccessLetter(self.indexMatchInWordFromChosenLetter)
    }
    
    private func updateGame() {
        guard let chosenLetterFromKeyboard else {return}
        if chosenLetterFromKeyboard.buttonInteration?.isPressed ?? true {return}
        verifyMatchToGallowsWord(chosenLetterFromKeyboard.text)
        updateLetterOnKeyboard()
        revealLetterInWord(self.indexMatchInWordFromChosenLetter, Theme.shared.currentTheme.primary, 1)
        revealGallowsDoll()
        checkEndGame()
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
        if indexMatchInWordFromChosenLetter.isEmpty {return false}
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
    }
    
    private func incrementSuccessLetter(_ indices: [Int]) {
        indices.forEach { index in
            successLetterIndex.insert(index)
        }
    }
    
    private func checkEndGame() {
        if isEndGameFailure() {
            configFailureEndGame()
        }
        
        if isEndGameSuccess() {
            configSuccessEndGame()
        }
    }
    
    private func isEndGameFailure() -> Bool {
        if errorLetters == errorCountToEndGame {
            isEndGame = true
            return true
        }
        return false
    }
    
    private func isEndGameSuccess() -> Bool {
        if successLetterIndex.count == getCurrentWord().word.count {
            isEndGame = true
            return true
        }
        return false
    }
    
    private func configFailureEndGame() {
        let colorError = Theme.shared.currentTheme.error
        changeColorGallows(colorError)
        changeDollFailure()
        revealOtherLetterInWord()
        saveLastPlayedWord()
    }
    
    private func configSuccessEndGame() {
        screen.gallowsView.ropeGallows.setHidden(true)
        screen.gallowsView.ropeCircleGallows.setHidden(true)
        screen.gallowsView.gallowsDollView.showDollSuccess()
        saveLastPlayedWord()
    }

    private func saveLastPlayedWord() {
        //TODO: - SAVE LOCAL REALM
    }
    
    private func revealOtherLetterInWord() {
        let setSuccessLetterIndex: Set<Int> = successLetterIndex
        let setWordIndex: Set<Int> = Set(0...(lettersInWord.count - 1))
        let indexToReveal = setWordIndex.subtracting(setSuccessLetterIndex).sorted()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.revealLetterInWord(indexToReveal, Theme.shared.currentTheme.error)
        }
    }
    
    private func changeDollFailure() {
        screen.gallowsView.gallowsDollView.showDollFailure()
    }
    
    private func changeColorGallows(_ color: UIColor) {
        screen.gallowsView.setColorGallows(color)
        screen.gallowsView.ropeGallows.neumorphism?.setReferenceColor(color).apply()
        screen.gallowsView.ropeCircleGallows.setTintColor(color)
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
    
    private func revealLetterInWord(_ indexLetter: [Int], _ color: UIColor, _ durationIncrement: Double = 0.5) {
        var duration = 0.5
        indexLetter.forEach { index in
            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(duration)) { [weak self] in
                guard let self else {return}
                screen.gallowsWordView.revealLetterInWord(lettersInWord[index], color)
            }
            duration += durationIncrement
        }
    }
    
    private func resetControls() {
        successLetterIndex = []
        errorLetters = 0
        isEndGame = false
        indexMatchInWordFromChosenLetter = []
        chosenLetterFromKeyboard = nil
    }
    
    private func configMoreTipView() {
        if isEndGame {return}
        screen.moreTipView.setHidden(false)
        showMoreTipViewAnimation()
        
    }
    
    
//  MARK: - ANIMATION Area
    
    private func showMoreTipViewAnimation() {
        screen.moreTipView.view.frame = CGRect(x: screen.gallowsKeyboardView.view.frame.origin.x, y: screen.gallowsKeyboardView.view.frame.maxY, width: screen.gallowsKeyboardView.view.bounds.width, height: 0)
        screen.moreTipView.setHidden(false)
        UIView.animate(withDuration: 0.5, delay: 0 , options: .curveEaseInOut, animations: { [weak self] in
            guard let self else {return}
            screen.moreTipView.view.frame.size = CGSize(width: screen.gallowsKeyboardView.view.bounds.width, height: screen.gallowsKeyboardView.view.bounds.height)
            screen.moreTipView.view.frame.origin.y = screen.gallowsKeyboardView.view.frame.origin.y
        })
    }
    
    private func hideMoreTipViewAnimation() {
        if screen.moreTipView.view.isHidden {return}
        UIView.animate(withDuration: 0.3, delay: 0 , options: .curveEaseInOut, animations: { [weak self] in
            guard let self else {return}
            screen.moreTipView.view.frame.size = CGSize(width: screen.gallowsKeyboardView.view.bounds.width, height: 0)
            screen.moreTipView.view.frame.origin.y = screen.gallowsKeyboardView.view.frame.maxY
            
        }, completion: {[weak self] _ in
            guard let self else {return}
            screen.moreTipView.setHidden(true)
        })
        
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
    
    func nextWord() {
        hideMoreTipViewAnimation()
        if isLastWord() { return  }
        resetControls()
        screen.resetHangmanView()
        screen.gallowsKeyboardView.resetKeyboard()
        createNextWord()
    }

}


//  MARK: - EXTENSION HangmanKeyboardViewDelegate
extension HangmanFloatViewController: HangmanKeyboardViewDelegate {
    func letterKeyboardTapped(_ letter: HangmanKeyboardLetterView) {
        if isEndGame {return}
        self.chosenLetterFromKeyboard = letter
        updateGame()
    }
    
    func moreTipTapped() {
        configMoreTipView()
    }
    
    
    
}

