//
//  PersistenceDataProtocol.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/07/23.
//

import RealmSwift
import Realm


protocol PersistenceDataProtocol {
    associatedtype Entity

    func insert(_ entity: Entity) async throws -> String
    func update(_ entity: Entity) async throws
    func delete(_ entity: Entity) async throws
    func fetch() async throws -> [Entity]
    func findBy(id: Any) async throws -> Entity
    
}



class Provider<T>: PersistenceDataProtocol {
    typealias Entity = T
    
    func delete(_ model: T) async throws {}
    func fetch() async throws -> [T] {
        return []
    }
    func insert(_ entity: T) async throws -> String {
        return ""
    }
    func update(_ entity: T) async throws {}
    func findBy(id: Any) async throws -> T {
        return T.self as! T
    }
}



class RealmProv<Entity: Object>: Provider<Entity> {
    
    private(set) var realm: Realm = try! Realm()
    
    override func delete(_ model: Entity) async throws {
    }
    
    override func fetch() async throws -> [Entity] {
        return try await withCheckedThrowingContinuation { continuation in
            let results = realm.objects(Entity.self)
            let entities = Array(results)
            continuation.resume(returning: entities)
        }
    }
    
    
    
}
