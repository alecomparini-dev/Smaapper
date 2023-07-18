//
//  HangmanService.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/06/23.
//

import Foundation

class HangmanService: GenericService {
    
    private let fileNameJson = K.Hangman.Service.fileNameJson
    private let extensionJson = K.Hangman.Service.extensionJson
    
    func fetchWordsFromLastPlayedWordInJson(lastPlayedWord: String, completion: @escaping (_ result: [HangmanWord], _ error: Error?) -> Void) {
        do {
            let result: HangmanData = try FetchDataInJson().fetch(fileNameJson, extensionJson)
            var hangmanWord: [HangmanWord] = result.words
            if let indexOfLastPlayedWord: Int = getIndexOfLastPlayedWord(result, lastPlayedWord) {
                hangmanWord = result.words.suffix(result.words.count - (indexOfLastPlayedWord+1))
            }
            completion(hangmanWord, nil)
        } catch {
            completion([], error)
        }
    }
    
    
    
//  MARK: - PRIVATE Area
    
    private func getIndexOfLastPlayedWord(_ hangmanData: HangmanData, _ lastPlayedWord: String) -> Int? {
        return hangmanData.words.firstIndex(where: { $0.word.elementsEqual(lastPlayedWord)})
    }
    
}
