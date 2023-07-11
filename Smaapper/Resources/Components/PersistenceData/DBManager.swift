//
//  DBManager.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/07/23.
//

import Foundation
import RealmSwift


class DBManager<T: Identifiable<UUID>>  {
    
    private(set) var provider: DBProviderStrategy<T>
    
    init(provider: DBProviderStrategy<T>) {
        self.provider = provider
    }
    
}

