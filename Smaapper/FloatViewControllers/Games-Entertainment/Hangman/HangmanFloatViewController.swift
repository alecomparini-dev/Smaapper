//
//  HangmanFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/06/23.
//

import UIKit


class HangmanFloatViewController: FloatViewController {
    static let identifierApp = K.Hangman.identifierApp
    
    private var lastPlayedWord: String = "arbitrio"
    
    private var viewModel: HangmanViewModel? = HangmanViewModel()
    private let errorCountToEndGame: Int8 = K.Hangman.errorCountToEndGame
    private let quantityLetterByLine = K.Hangman.quantityLetterByLine
    private var indicesToReveal: [Int] = []
    private var errorLetters: Int8 = 0
    private var successLetterIndex: Set<Int> = []
    private var lettersInWord: [HangmanLetterInWordView] = []
    private var indexMatchInWordFromChosenLetter: [Int] = []
    private var isEndGame: Bool = false
    private var hangmanWords: [HangmanWord] = []
    private var currentIndexPlayedWord: Int = -1
    private var chosenLetterFromKeyboard: HangmanKeyboardLetterView?
    
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
    
    deinit {
        print("chamou este também")
        chosenLetterFromKeyboard = nil
        hangmanWords = []
        viewModel = nil
        indicesToReveal = []
        successLetterIndex = []
        lettersInWord = []
        indexMatchInWordFromChosenLetter = []
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
        var y: CGFloat = K.Hangman.FloatView.y
        if #available(iOS 11.0, *) {
            let window = Utils.Window.currentWindow
            if let topSafeAreaInset = window?.safeAreaInsets.top {
                y = topSafeAreaInset
            }
        }
        setFrameWindow(CGRect(x: K.Hangman.FloatView.x,
                              y: y,
                              width: K.Hangman.FloatView.width,
                              height: K.Hangman.FloatView.height))
    }
    
    private func configInitialWord() {
        getIndexOfLastPlayedWord()
    }
    
    private func getIndexOfLastPlayedWord() {
        // Implementar
        fetchWords()
    }
    
    private func fetchWords() {
        viewModel?.fetchWordsFromLastPlayedWordInJson(.file, self.lastPlayedWord) { [weak self] result, error in
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
        revealLetterInWord(self.indexMatchInWordFromChosenLetter, Theme.shared.currentTheme.primary, K.Hangman.Animation.Duration.revealLetter)
        revealGallowsDoll()
        checkEndGame()
    }
    
    private func revealGallowsDoll() {
        if isChoseCorrectly() {return}
        revealBodyPart()
    }
    
    private func revealBodyPart() {
        switch errorLetters {
            case K.Hangman.ErrorLetters.firstError:
                screen.gallowsView.gallowsDollView.firstError()
            
            case K.Hangman.ErrorLetters.secondError:
                screen.gallowsView.gallowsDollView.secondError()
            
            case K.Hangman.ErrorLetters.thirdError:
                screen.gallowsView.gallowsDollView.thirdError()
            
            case K.Hangman.ErrorLetters.fourthError:
                screen.gallowsView.gallowsDollView.fourthError()
            
            case K.Hangman.ErrorLetters.fifthError:
                screen.gallowsView.gallowsDollView.fifthError()
            
            case K.Hangman.ErrorLetters.sixthError:
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
        configStyleButtonPressed(K.Hangman.cornerRadius, Theme.shared.currentTheme.surfaceContainerHighest)
        pressedButtonLetter()
    }
    
    private func updateLetterError() {
        incrementErrorCount()
        removeNeumorphismLetter()
        setShadowColorError()
        configStyleButtonPressed(K.Hangman.cornerRadius, Theme.shared.currentTheme.surfaceContainer)
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
        revealErrorLetterInWord()
        saveLastPlayedWord()
        showNextWord(wait: calculateWait())
    }
    
    private func calculateWait() -> Double {
        return (Double(indicesToReveal.count) * 0.5) + 1
    }
    
    private func showNextWord(wait: Double)  {
        DispatchQueue.main.asyncAfter(deadline: .now() + wait) { [weak self] in
            self?.screen.nextWordButton.setHidden(false)
        }
    }
    
    private func configSuccessEndGame() {
        screen.gallowsView.ropeGallows.setHidden(true)
        screen.gallowsView.ropeCircleGallows.setHidden(true)
        screen.gallowsView.gallowsDollView.showDollSuccess()
        saveLastPlayedWord()
        showNextWord(wait: 2)
    }

    private func saveLastPlayedWord() {
        //TODO: - SAVE LOCAL REALM
    }
    
    private func revealErrorLetterInWord() {
        let setSuccessLetterIndex: Set<Int> = successLetterIndex
        let setWordIndex: Set<Int> = Set(0...(lettersInWord.count - 1))
        indicesToReveal = setWordIndex.subtracting(setSuccessLetterIndex).sorted()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self else {return}
            revealLetterInWord(indicesToReveal, Theme.shared.currentTheme.error)
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
    
    private func revealLetterInWord(_ indexLetter: [Int], _ color: UIColor, _ durationIncrement: Double = K.Hangman.Animation.Duration.standard) {
        var duration = K.Hangman.Animation.Duration.standard
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
        screen.moreTipView.setHidden(false)
        showMoreTipViewAnimation()
    }
    
    private func showMoreTipsView() {
        screen.createHangmanMoreTipViewController(getCurrentWord().tips)
        screen.hangmanMoreTipViewController?.setDelegate(self)
    }
    
    private func positionMoreTip() {
        screen.moreTipView.view.frame = CGRect(x: screen.gallowsKeyboardView.view.frame.origin.x,
                                               y: screen.gallowsKeyboardView.view.frame.maxY,
                                               width: screen.gallowsKeyboardView.view.bounds.width,
                                               height: 0)
    }
    
    private func resetElements() {
        resetControls()
        screen.resetGallowsView()
        screen.resetGallowsWordView()
        screen.resetHangmanMoreTipViewController()
        screen.gallowsKeyboardView.resetKeyboard()
    }
    
    
//  MARK: - ANIMATION Area
    
    private func showMoreTipViewAnimation() {
        positionMoreTip()
        screen.moreTipView.setHidden(false)
        UIView.animate(withDuration: K.Hangman.Animation.Duration.standard, delay: K.Hangman.Animation.Delay.standard , options: .curveEaseInOut, animations: { [weak self] in
            guard let self else {return}
            screen.moreTipView.view.frame.size = CGSize(width: screen.gallowsKeyboardView.view.bounds.width + K.Hangman.MoreTip.margin,
                                                        height: screen.gallowsKeyboardView.view.bounds.height + K.Hangman.MoreTip.margin)
            screen.moreTipView.view.frame.origin = CGPoint(x:screen.gallowsKeyboardView.view.frame.origin.x - K.Hangman.MoreTip.positionX,
                                                           y:screen.gallowsKeyboardView.view.frame.origin.y - K.Hangman.MoreTip.positionY)
        }, completion: { [weak self] _ in
            guard let self else {return}
            showMoreTipsView()
        })
    }
    
    private func hideMoreTipViewAnimation() {
        if screen.moreTipView.view.isHidden {return}
        UIView.animate(withDuration: K.Hangman.Animation.Duration.hide, delay: K.Hangman.Animation.Delay.standard , options: .curveEaseInOut, animations: { [weak self] in
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
        resetElements()
        screen.nextWordButton.setHidden(true)
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


//  MARK: - EXTENSION HangmanKeyboardViewDelegate
extension HangmanFloatViewController: HangmanMoreTipViewDelegate {
    func didSelectRow(_ section: Int, _ row: Int) {
        
    }
    
    func closeMoreTipTapped() {
        screen.resetHangmanMoreTipViewController()
        hideMoreTipViewAnimation()
    }
    
    
}


