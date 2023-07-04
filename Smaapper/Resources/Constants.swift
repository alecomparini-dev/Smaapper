//
//  Constants.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/07/23.
//

import UIKit

struct K {
    static let appName = "Smaapper"
    
    
//  MARK: - CAMERA ARKIT
    struct CameraARKit {
        static let sizeTarget: CGFloat = 50
        struct Images {
            static let imageTarget = "viewfinder"
            static let imageBallTarget = "circle.fill"
        }
    }
    
    
//  MARK: - STICKY
    struct Sticky {
        static let identifierApp = "sticky_note"
        static let title = "Sticky Note"
        struct Images {
            static let logo = "note"
            static let imageTarget = "note"
        }
    }

    
//  MARK: - TAPE MEASURE
    struct TapeMeasure {
        static let identifierApp = "tape_measure"
        static let title = "Tape Measure"
        struct FloatView {
            static let positionX: CGFloat = 10
            static let positionY: CGFloat = 50
            static let width: CGFloat = (Utils.currentWindow?.screen.bounds.width ?? 300)-20
            static let height: CGFloat = 500
        }
        struct Images {
            static let logo = "ruler.fill"
            static let imageTarget = "note"
        }
    }
    
    
//  MARK: - HANGMAN
    struct Hangman {
        static let identifierApp = "hangman"
        static let cornerRadius: CGFloat = 15
        static let errorCountToEndGame: Int8 = 6
        static let quantityLetterByLine: Int = 10
        static let angleDollFailure: Double = 75
        struct FloatView {
            static let positionX: CGFloat = 30
            static let positionY: CGFloat = 30
            static let width: CGFloat = 290
            static let height: CGFloat = 550
        }
        struct Images {
            static let nextWordButton = "chevron.forward"
        }
        struct ErrorLetters {
            static let firstError: Int8 = 1
            static let secondError: Int8 = 2
            static let thirdError: Int8 = 3
            static let fourthError: Int8 = 4
            static let fifthError: Int8 = 5
            static let sixthError: Int8 = 6
        }
        struct MoreTip {
            static let margin: CGFloat = 13
            static let positionX: CGFloat = 6
            static let positionY: CGFloat = 4
        }
        struct Animation {
            struct Delay {
                static let standard : Double = 0
            }
            struct Duration {
                static let revealLetter: Double = 1
                static let standard: Double = 0.5
                static let hide: Double = 0.3
            }
        }
    }
}
