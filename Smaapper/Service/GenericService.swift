//
//  GenericService.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/05/23.
//


import Foundation

enum TypeFetch: String {
    case file = "file"
    case api = "api"
    case localStorage = "localStorage"
}

protocol GenericService: AnyObject {
    typealias completionService<T> = (_ result: T?, _ error: Error?) -> Void
}
