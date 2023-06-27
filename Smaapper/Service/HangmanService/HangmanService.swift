//
//  HangmanService.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/06/23.
//

import Foundation

class HangmanService: GenericService {
    
    private let fileNameJson = "HangmanWords"
    private let extensionJson = "json"
    
    
    func fetchWordsFromLastPlayedWordInJson(lastPlayedWord: String, completion: @escaping (_ result: [HangmanWord], _ error: Error?) -> Void) {
        if let jsonFileUrl = Bundle.main.url(forResource: fileNameJson, withExtension: extensionJson) {
            do {
                let jsonData = try Data(contentsOf: jsonFileUrl)
                let result = try JSONDecoder().decode(HangmanData.self, from: jsonData)
                
                var hangmanWord: [HangmanWord] = result.words
                if let indexOfLastPlayedWord: Int = getIndexOfLastPlayedWord(result, lastPlayedWord) {
                    hangmanWord = result.words.suffix(result.words.count - (indexOfLastPlayedWord+1))
                }
                completion(hangmanWord, nil)
            } catch {
                completion([], Error.fileDecodingFailed(name: fileNameJson , error))
            }
        } else {
            completion([], Error.fileNotFound(name: fileNameJson))
        }
    }
    
    
    
//  MARK: - PRIVATE Area
    
    private func getIndexOfLastPlayedWord(_ hangmanData: HangmanData, _ lastPlayedWord: String) -> Int? {
        return hangmanData.words.firstIndex(where: { $0.word.elementsEqual(lastPlayedWord)})
    }
    
}
