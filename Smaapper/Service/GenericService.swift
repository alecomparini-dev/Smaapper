//
//  GenericService.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/05/23.
//


import Foundation


enum Error: Swift.Error {
    case fileNotFound(name: String)
    case fileDecodingFailed(name: String, Swift.Error)
//    case errorRequest(AFError)
}

enum TypeFetch {
    case file
    case api
    case localStorage
}

protocol GenericService: AnyObject {
    typealias completion<T> = (_ result: T?, _ error: Error?) -> Void
}
