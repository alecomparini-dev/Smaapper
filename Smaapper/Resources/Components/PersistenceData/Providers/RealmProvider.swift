//
//  RealmProvider.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/07/23.
//

import RealmSwift


class RealmPersistence<T> {
    typealias Entity = T
        
    private let realm: Realm
    
    init() throws {
        realm = try Realm()
    }
    
}

extension RealmPersistence: PersistenceData {
    func fetch() async throws -> [T] {
        return []
    }
    
    
    func insert(_ model: Entity) async throws -> String {
        return ""
    }
    
    func update(_ model: Entity) async throws {
                
    }
    
    func delete(_ model: Entity) async throws {
        
    }
    
    func findBy(id: Any) async throws -> T {
        return T.self as! T
    }
    
    
}
