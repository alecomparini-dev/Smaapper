//
//  Constants.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/07/23.
//

import UIKit

struct K {
    static let appName = "Smaapper"
    static var worldMapData: Data = Data()
    
    struct String {
        static let dot = "."
        static let comma = ","
        static let zeroDouble = "0.0"
        static let zero = "0"
        static let empty = ""
        static let one = "1"
        static let two = "2"
        static let three = "3"
        static let four = "4"
        static let five = "5"
        static let six = "6"
        static let seven = "7"
        static let eight = "8"
        static let nine = "9"
    }
    

    
//  MARK: - CAMERA ARKIT
    struct Proportion {
        static let identifierApp = "proportion"
        static let title = "Proportion"
        static let labelOkButton = "Ok"
        static let maxDigits: Int = 4
        
        struct FloatView {
            static let x: CGFloat = 50
            static let y: CGFloat = 150
            static let width: CGFloat = 290
            static let height: CGFloat = 180
        }
        
        struct Images {
            static let logo = "3.square.fill"
            static let refresh = "arrow.counterclockwise"
            static let copy = "doc.on.doc"
            static let history = "ellipsis"
        }
    }
    
    
//  MARK: - ALCOHOL
    struct Alcohol {
        static let identifierApp = "alcohol_gasoline"
        static let title = "Alcohol x Gasoline"
        
        struct Images {
            static let logo = "fuelpump.fill"
        }
    }
    
    
//  MARK: - STICKY
    struct Sticky {
        static let identifierApp = "sticky_note"
        static let title = "Sticky Note"
        static let corSticky: UIColor = Theme.shared.currentTheme.primary
        static let maxLetterNote: Int = 50
        
        struct AR {
            static let fontSizeNote: CGFloat = 10
            struct Frame {
                static let cornerRadius: CGFloat = 3
                struct Default {
                    static let x: CGFloat = 0
                    static let y: CGFloat = 0
                    static let width: CGFloat = 100
                    static let height: CGFloat = 80
                }
                struct Top {
                    static let x: CGFloat = 0
                    static let y: CGFloat = 0
                    static let width: CGFloat = 100
                    static let height: CGFloat = 15
                }
                struct Note {
                    private static let margin: CGFloat = 5
                    static let x: CGFloat = 5
                    static let y: CGFloat = Top.height
                    static let width: CGFloat = Default.width - Note.x - Note.margin
                    static let height: CGFloat = Default.height - Note.y - Note.margin
                }
            }
        }
        
        struct FloatView {
            static let x: CGFloat = 10
            static let y: CGFloat = (Utils.Window.currentWindow?.safeAreaInsets.top ?? 30) + 10
            static let width: CGFloat = (Utils.Window.currentWindow?.screen.bounds.width ?? 300)-20
            static let height: CGFloat = 500
        }
        
        struct Images {
            static let logo = "note"
            static let imageTarget = "note"
        }
    }

    
    //  MARK: - WHAT BEER
        struct WhatBeer {
            static let identifierApp = "what_beer"
            static let title = "What Beer"
            
            struct FloatView {
                static let x: CGFloat = 10
                static let y: CGFloat = (Utils.Window.currentWindow?.safeAreaInsets.top ?? 30) + 10
                static let width: CGFloat = (Utils.Window.currentWindow?.screen.bounds.width ?? 300)-20
                static let height: CGFloat = 500
            }
            
            struct Images {
                static let logo = "vial.viewfinder"
                static let target = "plus"
                static let captureButton = "camera.viewfinder"
            }
        }
    
//  MARK: - TAPE MEASURE
    struct TapeMeasure {
        static let identifierApp = "tape_measure"
        static let title = "Tape Measure"
        
        struct FloatView {
            static let x: CGFloat = 10
            static let y: CGFloat = (Utils.Window.currentWindow?.safeAreaInsets.top ?? 30) + 10
            static let width: CGFloat = (Utils.Window.currentWindow?.screen.bounds.width ?? 300)-20
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
        
        struct Service {
            static let fileNameJson = "HangmanWordsData"
            static let extensionJson = "json"
        }
        
        struct FloatView {
            static let x: CGFloat = 30
            static let y: CGFloat = 30
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
