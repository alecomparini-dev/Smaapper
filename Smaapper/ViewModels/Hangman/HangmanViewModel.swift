//
//  HangmanViewModel.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/06/23.
//

import UIKit


class HangmanViewModel {
    
    private let service: HangmanService
    
    init(service: HangmanService) {
        self.service = service
    }
    
    func fetchWordsFromLastPlayedWord(_ type: TypeFetch, _ lastPlayedWord: String,  completion: @escaping (_ result: [HangmanWord], _ error: Error?) -> Void) {
        switch type {
            
        case .file:
            service.fetchWordsFromLastPlayedWordInJson(lastPlayedWord: lastPlayedWord, completion: completion)
        
        case .api:
            break
            
        case .localStorage:
            break
        }
        
    }
    
}
