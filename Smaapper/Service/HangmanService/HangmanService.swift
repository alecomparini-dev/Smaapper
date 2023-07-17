//
//  HangmanService.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/06/23.
//

import Foundation

class HangmanService: GenericService {
    
    func fetchWordsFromLastPlayedWordInJson(lastPlayedWord: String, completion: @escaping (_ result: [HangmanWord], _ error: Error?) -> Void) {
        if let jsonFileUrl = Bundle.main.url(forResource: K.Hangman.Service.fileNameJson, withExtension: K.Hangman.Service.extensionJson) {
            do {
                let jsonData = try Data(contentsOf: jsonFileUrl)
                let result = try JSONDecoder().decode(HangmanData.self, from: jsonData)
                
                var hangmanWord: [HangmanWord] = result.words
                if let indexOfLastPlayedWord: Int = getIndexOfLastPlayedWord(result, lastPlayedWord) {
                    hangmanWord = result.words.suffix(result.words.count - (indexOfLastPlayedWord+1))
                }
                completion(hangmanWord, nil)
            } catch {
                completion([], FileError.fileDecodingFailed(error: K.Hangman.Service.fileNameJson , error))
            }
        } else {
            completion([], FileError.fileNotFound(error: K.Hangman.Service.fileNameJson))
        }
    }
    
    
    
//  MARK: - PRIVATE Area
    
    private func getIndexOfLastPlayedWord(_ hangmanData: HangmanData, _ lastPlayedWord: String) -> Int? {
        return hangmanData.words.firstIndex(where: { $0.word.elementsEqual(lastPlayedWord)})
    }
    
}
